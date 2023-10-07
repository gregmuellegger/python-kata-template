# Start a new kata, by creating a new branch.
start name:
    git checkout -b {{name}}-`date +"%Y-%m-%d"` main
    code kata/code.py kata/code_test.py

# Forget the current attempt and switch back to main.
forget:
    # Check that we are not on main.
    ! [ $(git rev-parse --abbrev-ref HEAD) = "main" ] 

    git reset --hard
    git checkout main
