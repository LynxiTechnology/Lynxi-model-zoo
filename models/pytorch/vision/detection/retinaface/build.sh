#! /bin/bash

set -e

# prepare codes and dependencies
function 1_prepare() {
    cd "$TOP"
    [[ ! -d "${source_dir}" ]] && git clone "${source_url}"

    cd "${source_dir}"
    git checkout b984b4b775b2c4dced95c1eadd195a5c7d32a60b
    git am ../patch/*.patch

    [[ ! -d "weights" ]] && mkdir weights
    [[ ! -d "dump_log" ]] && mkdir dump_log
    cd weights
    # [[ ! -f "mobilenet0.25_Final.pth" ]] && wget --no-check-certificate -c --referer="https://pan.baidu.com/s/12h97Fy1RYuqMMIV-RpzdPg" \
    #     -O "mobilenet0.25_Final.pth" \
    #     "https://xaky-ct01.baidupcs.com/file/d308262876f997c63f79c7805b2cdab0?bkt=en-6766f9da69592c1257399d78fbf1634086cd12212d8a3ad46b31fa7a176e3f03816fa46b5ac1f01e019d9d715438d2f96e78aa8e02be0e0ca8a81b20fe359820&fid=1697260996-250528-503949082403772&time=1655794678&sign=FDTAXUbGERQlBHSKfWqiu-DCb740ccc5511e5e8fedcff06b081203-thW2dpXDua16%2BCxO%2BhkDxdMDTS0%3D&to=423&size=1789735&sta_dx=1789735&sta_cs=2365&sta_ft=pth&sta_ct=7&sta_mt=7&fm2=MH%2CXian%2CAnywhere%2C%2Chubei%2Cct&ctime=1569982087&mtime=1569982087&resv0=-1&resv1=0&resv2=rlim&resv3=5&resv4=1789735&vuk=3928813655&iv=2&htype=&randtype=&tkbind_id=0&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=en-bcf806f3ae82307e2dd405c9e7896faf214bbe4ac4ca8b7bfefc7a31d9370d76b987f530fb938b14f6dc8c95d4bb5a7b8d6b94056c279d86305a5e1275657320&expires=8h&rt=sh&r=741623213&vbdid=803879441&fin=mobilenet0.25_Final.pth&fn=mobilenet0.25_Final.pth&rtype=1&dp-logid=521671116571871449&dp-callid=0.1&hps=1&tsl=0&csl=0&fsl=-1&csign=MwPBAnlwILPwaKvyRq38%2FTyVru8%3D&so=0&ut=1&uter=4&serv=0&uc=2483642215&ti=c77e04c9862927e53a766efbf838a1cad050b1d5be86e7c2e3611405bef53ec1&hflag=30&from_type=0&adg=c_24e13c04395e8fc91a9ead3fdc7811a1&reqlabel=250528_f_0544aea2788bb8334e4219518c63824b_-1_77ec743c05942fa8fbcbb0efc1e594c3&by=themis&resvsflag=1-0-0-1-1-1"
    # [[ ! -f "mobilenetV1X0.25_pretrain.tar" ]] && wget --no-check-certificate -c --referer="https://pan.baidu.com/s/12h97Fy1RYuqMMIV-RpzdPg" \
    #     -O "mobilenetV1X0.25_pretrain.tar" \
    #     "https://xafj-ct11.baidupcs.com/file/842f139f153a509bdc120c07c4f792dd?bkt=en-1d4f88d1767dc137e97e9c5c5238df8037b33fac06509392880b1fa77cb2b011233c71231c76b5242282eea4ec1a903d52313abfac21730f2d718f4faced2c0f&fid=1697260996-250528-865747490394621&time=1655794822&sign=FDTAXUbGERQlBHSKfWqiu-DCb740ccc5511e5e8fedcff06b081203-VuwQ1ut02%2FiDYkA72b4%2FAkBifV8%3D&to=417&size=3827150&sta_dx=3827150&sta_cs=2372&sta_ft=tar&sta_ct=7&sta_mt=7&fm2=MH%2CXian%2CAnywhere%2C%2Chubei%2Cct&ctime=1569982084&mtime=1569982084&resv0=-1&resv1=0&resv2=rlim&resv3=5&resv4=3827150&vuk=3928813655&iv=2&htype=&randtype=&tkbind_id=0&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=en-6b0724c7e57b53e77c3f609e872a753b382a6c8ed0fc22e8cf45984ab0b10e9fed0e7a73918e1c24a4bb02b30fc2f276a22582725c6cd289305a5e1275657320&expires=8h&rt=sh&r=995640018&vbdid=803879441&fin=mobilenetV1X0.25_pretrain.tar&fn=mobilenetV1X0.25_pretrain.tar&rtype=1&dp-logid=521709805733911782&dp-callid=0.1&hps=1&tsl=0&csl=0&fsl=-1&csign=MwPBAnlwILPwaKvyRq38%2FTyVru8%3D&so=0&ut=1&uter=4&serv=0&uc=2483642215&ti=c77e04c9862927e54933639a2815a1cfe1f881a666266472305a5e1275657320&hflag=30&from_type=0&adg=c_24e13c04395e8fc91a9ead3fdc7811a1&reqlabel=250528_f_0544aea2788bb8334e4219518c63824b_-1_77ec743c05942fa8fbcbb0efc1e594c3&by=themis&resvsflag=1-0-0-1-1-1"
    tempFile="${TOP}/patch/mobilenet0.25_Final.pth"
    [[ -f "${tempFile}" ]] && cp -f "${tempFile}" .
    tempFile="${TOP}/patch/mobilenetV1X0.25_pretrain.tar"
    [[ -f "${tempFile}" ]] && cp -f "${tempFile}" .
    pip3 install -r "${TOP}/golden/requirements.txt"

    cd -
    python3 main_myself.py -m ./weights/mobilenet0.25_Final.pth \
        --network mobile0.25 --cpu --target "target"
}

# convert to lynxi model
function 2_convert() {
    echo "have done in stage '1_prepare'"
}

# infer by lynxi model
function 3_test() {
    cd "${source_dir}"
    python3 main_myself.py -m ./weights/mobilenet0.25_Final.pth \
        --network mobile0.25 --cpu --target "myself"
}

# compare output by original and lynxi's model
function 4_detect() {
    echo "have done in stage '3_test'"
}

function init() {
    source_url="https://github.com/biubug6/Pytorch_Retinaface"
    source_dir="$TOP/Pytorch_Retinaface"
}

function inlet() {
    echo "** mode: $1"
    init

    if [[ "$1" == "1_prepare" ]]; then
        1_prepare
    elif [[ "$1" == "2_convert" ]]; then
        2_convert
    elif [[ "$1" == "3_test" ]]; then
        3_test
    elif [[ "$1" == "4_detect" ]]; then
        4_detect
    else
        echo "cannot support your option, and exit" && exit 1
    fi

}

file_install=$(readlink -f "$0")
export TOP=$(dirname "${file_install}")
inlet "$@"
