# Git usage
## Push local to remote repo
'''
echo "# awsscaling" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:thebestlearner-ric/awsscaling.git
git push -u origin main
'''
## Issue with git and terraform
Description: within .gitignore file does not ignore .terraform folder
Way to resolve:
'''
git add .
git commit -m "text you want to add"
git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/'
git push 
''' 
ref: https://github.com/hashicorp/terraform-guides/issues/92