Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC054681
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 03:57:42 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D3tj8c017952;
	Thu, 13 Jul 2023 03:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dJZOCQQwGsnpYcN+YHaXrMXkKkkr6QOmOzHB+k/r3Og=;
 b=FvIXXJ4FJTBjjL/Cy58G5E3FnpfUe0bl6hiorXfpjF8CwTJzVczN4671HgkSi+rf8CYH
 LqLqmXa7JRrpk8NKLIJMiEqWMNIormPS4YXYy7c6n+v1zoxU0hzdsuU1VQx/7gV2KrFF
 WoKiVnHyXLOccQmiY/pxSZWBL9pZ2i2YdW4MsKN1QY7YGjqIGN9Z7Serd/BVDPgAL5YV
 o1MltfAqKdt2gln7uRuTcYP6zIzZnZGLfyI/xY6WaGuxzK+/fxud6yIMKNPxI+Ur4gzA
 ue42dmipq8kdGfLLwLGnPfpMbbSdcIBiyaHWmPqLGvJVvfWOJFtfCxIZ+FztcgHPZeDl Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt89tr4ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jul 2023 03:56:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D3udmp017412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jul 2023 03:56:39 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 20:56:38 -0700
Message-ID: <99c9d49e-8a8c-0dc1-c77c-d0dcd7ae2961@quicinc.com>
Date: Thu, 13 Jul 2023 11:56:36 +0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, <iwd@lists.01.org>,
        <iwd@lists.linux.dev>
CC: Denis Kenzior <denkenz@gmail.com>
References: <20210903193544.13897-3-prestwoj@gmail.com>
 <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
 <411c867b-f830-c66c-4c21-f59200993b2a@gmail.com>
 <00246aa8-fe45-f5c2-cf2a-3450cee414f2@quicinc.com>
 <d2a490cf-ae06-ed26-33eb-5475616bd725@gmail.com>
 <03b87aea-9d3b-78b5-e187-94c4310982cb@quicinc.com>
 <0617fffe-2f26-bceb-5bd9-782882f24dd0@gmail.com>
From: Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <0617fffe-2f26-bceb-5bd9-782882f24dd0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FjNueKK8aCRLM1EhmdjMjz3dsJ_uZEHL
X-Proofpoint-GUID: FjNueKK8aCRLM1EhmdjMjz3dsJ_uZEHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_01,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=724 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130033

On 7/13/2023 11:04 AM, James Prestwood wrote:
...
> Indeed, it doesn't include the RSNE as it should. Out of curiosity do 
> you know what AP model/manufacturer this is? Its nice to document this 
> for others and to reference in the future.
>
> Thanks for digging into this. If Denis is fine with relaxing the check 
> I'll send a patch and take care of that.

let us wait Denis :).

It has more than one manufacturer AP happened the OWE fail.

>
> Thanks,
> James
>
>>
...
>> I think above hexdump is readable/enough, if it is not, I will use 
>> iwmon to collect again.
>>> Denis,
>>>
>>> Is relaxing the RSNE check in the associate response (for OWE only) 
>>> something you'd be ok with? Obviously with an L_WARN_ON/l_warn message.
>>>
>>> Thanks,
>>> James
