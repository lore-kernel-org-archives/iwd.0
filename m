Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01D3D71
	for <iwd@lists.linux.dev>; Fri, 14 Jul 2023 03:56:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E3YkvE026270;
	Fri, 14 Jul 2023 03:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VRlMyZfs2nrV3tOK8hClD1LdGO2XMRyZSCsnPAL3IQQ=;
 b=QSgHHHWh2/9jm1pCs/94ri94odAgBuKyJVuYRBEaD4VzkCr+TUUWKHbNFUwr3mv/SeFM
 L/mC/8vuC1YGA9uVu41T4OfU3OpuIONEL5bnKR/SNR928zbA1Y+hEMA8f0iiPzDOQA3R
 +zQpiA01VPY+JCzntmk29pxztY8jeCqIYF0nOkIjTVjf96l7+EX7s13fwQU7M5oyUfId
 0u6u16zQGvDX31tT63JHTCZYjye+ulpe/ITCovWasa+j0TWzkOVyQI6s8N7CFv1ePpfU
 YDwNw3Kuwg9DJRusgNHY39PxR5VeAAAXjHt2togXTlN4vYeWc6U4pvER/7pSCLns/XAP nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpub8rs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 03:56:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E3ugrA012118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 03:56:42 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 20:56:41 -0700
Message-ID: <25dfa954-ffc3-a750-d880-8f9ed6a26384@quicinc.com>
Date: Fri, 14 Jul 2023 11:56:38 +0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] netdev: relax requirement for OWE AKM in assoc reply
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
        <iwd@lists.linux.dev>
References: <20230713144237.2977210-1-prestwoj@gmail.com>
 <5c6f96fa-dd84-df1a-7684-5692944fcb4e@gmail.com>
From: Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <5c6f96fa-dd84-df1a-7684-5692944fcb4e@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uW-DIr7uoOG5OKflCPGx5s5dQcV9ew9Q
X-Proofpoint-GUID: uW-DIr7uoOG5OKflCPGx5s5dQcV9ew9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_01,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=739 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140035

On 7/14/2023 11:51 AM, Denis Kenzior wrote:
> Hi James,
>
> On 7/13/23 09:42, James Prestwood wrote:
>>
...
>
> Looks fine to me.
>
> Wen, any chance you can test this patch so I can also add your Tested-By?
>
> Regards,
> -Denis
I have tested it before:
Jul 11 20:32:32.646611 wd[1024]: src/netdev.c:netdev_mlme_notify() MLME 
notification Connect(46)
Jul 11 20:32:32.646611 wd[1024]: src/netdev.c:netdev_connect_event()
Jul 11 20:32:32.646611 wd[1024]: not care OWE DH element/RSN not found
Jul 11 20:32:32.681820 wd[1024]: src/station.c:station_connect_cb() 5, 
result: 0
Jul 11 20:32:32.681820 wd[1024]: src/station.c:station_connect_ok()

