venv_path := justfile_directory() / ".venv"
set dotenv-load := true

terraform := "terraform -chdir=" + justfile_directory() / "infra"

default:
    just --choose

bootstrap:
    {{ terraform}} init

_make_plan:
    #!/bin/bash
    rm -f plan.just 2>/dev/null
    plan_logs_file=$(mktemp)
    trap 'rm -f "$plan_logs_file"' EXIT
    {{terraform}} plan -out plan.just >"$plan_logs_file" 2>&1
    if [ $? -ne 0 ]; then
        echo "Error during terraform plan. See logs:"
        cat "$plan_logs_file"
        exit 1
    fi

show-plan:
    @{{terraform}} show plan.just

plan: _make_plan && show-plan

apply:
    {{terraform}} apply plan.just
