from django.urls import include, path
from . import views

app_name = "app"

urlpatterns = [
    path("", views.index, name="index"),
    path("create/", views.create_message, name="create"),
]