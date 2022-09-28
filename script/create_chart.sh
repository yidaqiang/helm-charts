#!/bin/bash

TEMAPLTE_CHART_PATH="../template/CHART_NAME"
TARGET_CHART_PATH="../vista/${1}"

declare -A chartMap=(
    ["%%CHOOSE_ONE_FROM_CHART_CATEGORIES_FILE%%"]="DeveloperTools"
    ["%%UPSTREAM_PROJECT_VERSION%%"]="1.9.4"
    ["%%DESCRIPTION%%"]="HedgeDoc - The best platform to write and share markdown."
    ["%%UPSTREAM_PROJECT_URL%%"]="https://hedgedoc.org/"

    ["%%UPSTREAM_PROJECT_KEYWORD%%"]="hedgedoc"
    ["%%CHART_NAME%%"]="hedgedoc"
    ["%%UPSTREAM_PROJECT_SOURCE_CODE_URL%%"]="https://github.com/hedgedoc/hedgedoc"

    ["%%SUBCHART_NAME%%"]="postgresql"
    ["SUBCHART_NAME"]="postgresql"
    ["%%MAJOR_SUBCHART_VERSION_(A.X.X)%%"]="11.x.x"
    #["%%OTHER_PARAMETERS_RELATED_TO_THIS_SUBCHART%%"]=""

    ["%%INTRODUCTION%%"]="HedgeDoc - The best platform to write and share markdown."
    ["%%MAIN_OBJECT_BLOCK%%"]="hedgedoc"
    ["%%IMAGE_NAME%%"]="hedgedoc"
    ["%%IMAGE_TAG%%"]="1.9.4"
    ["%%OTHER_PARAMETERS_RELATED_TO_THIS_CONTAINER/POD%%"]=""
    #["%%SECONDARY_OBJECT_BLOCK%%"]=""
    #["%%OTHER_OBJECT_BLOCK%%"]=""
    #["%%SAME_STRUCTURE_AS_THE_MAIN_CONTAINER/POD%%"]=""
    ["%%COMPONENT_NAME%%"]="hedgedoc"
    ["%%IMAGE_REVISION%%"]="32"
    ["%%CONTAINER_NAME%%"]=""

    # _helpers.tpl
    ["%%TEMPLATE_NAME%%"]="hedgedoc"
    ["%%PORT_NAME%%"]="http"
)

function replace_parameters() {
    if [ -n ${1} ];
    then
	for key in ${!chartMap[@]}; do
	    #e="s/${key}/${chartMap[$key]}/g"
	    sed -i "s!${key}!${chartMap[$key]}!g" $1
	done
    else
        echo "路径为空，跳过替换。"
    fi
}

function traverse_file() {
    if [ -d ${1} ];
    then
        for e in `ls ${1}`
	do
            path=${1}"/"${e}
            if [ -d ${path} ]
	    then
                traverse_file ${path}
            else
                replace_parameters ${path}
            fi
	done
    fi
}

function init_chart() {
    if [ -d ${TARGET_CHART_PATH} ];
    then
        echo "chart 目录已经存在，已跳过创建。"
    else
	echo "正在创建chart..."
        cp -r ${TEMAPLTE_CHART_PATH} ${TARGET_CHART_PATH}
	traverse_file ${TARGET_CHART_PATH}
    fi
}


init_chart
