from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from .forms import MessageForm
from .models import Message

def index(request):
    messages = Message.objects.order_by("-created")[:50]
    return render(request, "app/index.html", {"messages": messages})

@login_required
def create_message(request):
    if request.method == "POST":
        form = MessageForm(request.POST)
        if form.is_valid():
            msg = form.save(commit=False)
            msg.author = request.user
            msg.save()
            return redirect("app:index")
    else:
        form = MessageForm()
    return render(request, "app/create_message.html", {"form": form})