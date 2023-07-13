Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BC7C
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 03:08:29 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D1bqnY025979;
	Thu, 13 Jul 2023 03:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XZf4b9m9iJW7oi1lNR1naqPrXcltbmidqWXyJXzCwho=;
 b=cRRBD8emlsmf3vNDq3JDwIYJyBQ6lrPVhU9EcX3MLhSRwlUVIPJ3lZZ/b/ZgpOObUTGc
 3QSOHNcPYuEH2aeGtUH/a3ZXL/++PpxUpZunCjLo6H+04tXkjAHq85bJq+e+Jgxc1+2x
 xgdylVO315PspktWkVRjN/DCmD0WmluogyKIqS2APc9vKd40z8F6hHh8I20yKjuz9Bad
 f5rGUNsDmKBIrdstDrPWQ0maiiLcArFLGYxKREUkjlKZJAksrTjSLfTTDdaRT7TavsT0
 ZYD9HPujCJqD0yGENZQcoaUN737YNyuPQaIPozmuXRkQODj5MiSqbVxOgxaNNLSHIhVf cQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt57mrb2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jul 2023 03:07:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D37RRP032360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jul 2023 03:07:27 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 20:07:25 -0700
Message-ID: <84d37909-756b-f09f-904f-a4310335bb2b@quicinc.com>
Date: Thu, 13 Jul 2023 11:07:23 +0800
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
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l0nGBlmZrRMmZhV0LyO5mtJOrsynRgpf
X-Proofpoint-GUID: l0nGBlmZrRMmZhV0LyO5mtJOrsynRgpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_17,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=881 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130025

On 7/13/2023 11:04 AM, James Prestwood wrote:
> Hi Wen,
>
>>
>> ======================Association Response start======================
>>
...
> Indeed, it doesn't include the RSNE as it should. Out of curiosity do 
> you know what AP model/manufacturer this is? Its nice to document this 
> for others and to reference in the future.
>
Hi James,

you can see the assoc request, it is ASUS 6 GHz AP.

Tag: SSID parameter set: ASUS-6GAP
     Tag Number: SSID parameter set (0)
     Tag length: 9
     SSID: ASUS-6GAP

> Thanks for digging into this. If Denis is fine with relaxing the check 
> I'll send a patch and take care of that.
>
> Thanks,
> James
>
>>
>>
...
