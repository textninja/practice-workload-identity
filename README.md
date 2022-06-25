# Practice Workload Identity

This repo is my way of practicing workload identity in Google Kubernetes Engine.
My objective is to use workload identity to give a pod running in my Kubernetes
cluster access to the following:

 - a cloud storage bucket
 - a bigquery
 - a cloud secret

As a stretch goal, if there's time, I'd like to give it access to a Cloud SQL database as well. 

I'm using the following to guide me:

 - https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity
