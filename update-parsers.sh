#!/bin/sh

schema-salad-tool --codegen dlang --codegen-package cwl_d_auto.v1_0 --codegen-parser-info "CWL v1.0 parser generated with schema-salad-tool" \
    --codegen-examples resources/cwl-v1.0 \
    https://github.com/common-workflow-language/common-workflow-language/raw/codegen/v1.0/CommonWorkflowLanguage.yml > source/cwl_d_auto/v1_0.d

schema-salad-tool --codegen dlang --codegen-package cwl_d_auto.v1_1 --codegen-parser-info "CWL v1.1 parser generated with schema-salad-tool" \
    --codegen-examples resources/cwl-v1.1 \
    https://github.com/common-workflow-language/cwl-v1.1/raw/codegen/CommonWorkflowLanguage.yml > source/cwl_d_auto/v1_1.d

schema-salad-tool --codegen dlang --codegen-package cwl_d_auto.v1_2 --codegen-parser-info "CWL v1.2 parser generated with schema-salad-tool" \
    --codegen-examples resources/cwl-v1.2 \
    https://github.com/common-workflow-language/cwl-v1.2/raw/1.2.1_proposed/CommonWorkflowLanguage.yml > source/cwl_d_auto/v1_2.d
