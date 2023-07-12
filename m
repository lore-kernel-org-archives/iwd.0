Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6803FFE
	for <iwd@lists.linux.dev>; Wed, 12 Jul 2023 11:18:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CBDwGu005163;
	Wed, 12 Jul 2023 11:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V+V3TYWDoGD/njadRAxA/zdbsVCrf1osYjbzis/JC8Q=;
 b=YoA/nMWOif9WYBMy34Vr+gROpvvUJKLK4X9O6Wml6oIs3YwKtz+7u/2Eu7ph0tLW2IR3
 vbn3Cg/Hk7LBJL7wlAU0tKxhRvQbYGNVMvfURmjPfZeX/bvIGMpBpnhAa1P1LNg1tRuO
 vnlCLsQQ8UhrS6Xbsqa7TdZDzskvC0raWF9nvPHbKOy1dD/CqE7a3C2CTyyvYQFGeIjm
 OzeFjxWd6kgbgj/HBmVLkIZ9qlbsM+idjuABznH8/uhiyzOUjE6a1DGOgR1mEnVO+Xpj
 af8E+X8DPm1nGE9D+gGIuC7mUbFo2rorZ/3+YRg/bUZFWKnmjpqpT9rEvSO6V/MJXUO5 hA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rshyu91vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 11:17:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBHhKI013251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 11:17:43 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 04:17:41 -0700
Message-ID: <a7e76f73-da60-57fd-6686-b26e5c342d87@quicinc.com>
Date: Wed, 12 Jul 2023 19:17:37 +0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] owe: netdev: refactor to remove OWE as an
 auth-proto
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, <iwd@lists.01.org>,
        <iwd@lists.linux.dev>
References: <20210903193544.13897-3-prestwoj@gmail.com>
From: Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20210903193544.13897-3-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c7IAWcZavOjTcYkp6hv8b7pUkcd4u668
X-Proofpoint-ORIG-GUID: c7IAWcZavOjTcYkp6hv8b7pUkcd4u668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120100

On 9/4/2021 3:35 AM, James Prestwood wrote:
> ---
...
> +
> +			case IE_TYPE_RSN:
> +				if (!netdev->owe_sm)
> +					continue;
> +
> +				if (ie_parse_rsne(&iter, &info) < 0) {
> +					l_error("could not parse RSN IE");
> +					goto error;
> +				}
> +
> +				/*
> +				 * RFC 8110 Section 4.2
> +				 * An AP agreeing to do OWE MUST include the OWE AKM in
> +				 * the RSN element portion of the 802.11 association
> +				 * response.
> +				 */
Now it is happen connect to OWE AP fail with some APs, because the assoc 
resp do not inclued RSNE.
> +				if (info.akm_suites != IE_RSN_AKM_SUITE_OWE) {
> +					l_error("OWE AKM not included");
> +					goto deauth;
> +				}
> +
> +				owe_akm_found = true;
> +
> +				break;
> +			}
> +		}
> +
> +		if (netdev->owe_sm) {
> +			if (!owe_dh || !owe_akm_found) {
> +				l_error("OWE DH element/RSN not found");

It failed here.

So is the check for owe_akm_found MUST added here if owe_dh is existed 
in assoc resp?

> +				goto error;
>   			}
...
