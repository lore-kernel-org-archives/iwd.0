Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A15339D
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867666; cv=none; b=ULubbEzbppXpsNQAYapEhm58t2abt8idmkv3LH3PO1VlLY78Ns3eHI7KDFmvB8shN4O3L1GY5AAbhMFbC02EuJGIEvpGam0bBL2adrivyGRfV3OixkF/lZ3aR/FuSighTf1/seaqM8OfEGikifMWFV2gEdTjipfo9K0+BrVndZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867666; c=relaxed/simple;
	bh=nXoMqrMNsnD1Omyw34+lg717mmCBilo97c44Gho1QMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oWC8+ubVEdesEEeNwfRooScqJ8RTcG4n473qu10bpFmLIgwcPVpN8YmtGsej2Ci+RG2hm6mp/75zAWtZvDWv0+y3XTSMbgHURG/cgkDR6qSeHDGeuhyRHpEYrhwZZ0beRO0P6lWjUG6KWN2CT6+m6oR226IeeyLi3WI+5TMesHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDPsJpS1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDPsJpS1"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66ca5e8cc51so95727647b3.1
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722867663; x=1723472463; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ks7ugHydiLoArN4W8KVvhEI/jMuY2Q9duNT1UF24pnQ=;
        b=GDPsJpS1Rj8Zq2QVb6dAmoGeu9HWAE6s04mNTHcMVUcy3x7BzJ30QA1d61EH5DrxcB
         kZSKYMS5X3UHJdW5r7GfOa0njK/eO47fEZ/DfNFatAxGfEozJdeb70NwnZBCAD4QLmRw
         Tb6bOaKFv49x+CdUuQ9pDGBPYazYL0Co6iOHe5EqlqM0Ip0msuH3R+8+Zgio/6Q0E69O
         f0Qi4J15gzz5Nsu46xMDmxkHBKvE0Vw5o2JvfK3zE5mRSbB3M6EtGIeapvc09e/uDbp4
         oJYm+YQBz4GsXtvHmwZ+BaM+EK1q0qo53yRTwj6naGBr1veGyLzh/INIDM0kTqlumtdl
         ZLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722867663; x=1723472463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks7ugHydiLoArN4W8KVvhEI/jMuY2Q9duNT1UF24pnQ=;
        b=tjTy1r/TsnYqN3ziR4uQVcJc8rBlQRCneC2Pg6HAKkhQoGT3NBFol5mgaJbwkhS+s2
         ctsEh4h8OWuvAtTUBMVToeo1H5t61ZaG56DORNkPJKuIrEwITxFh6mXvPkk/n0WeWXyH
         dvNBUAFY0OjvAV2lHFrgkY7f9h1ir6d0fkv2exl8aOw7meRF7LCanqxpWzqW/9ZLsVS/
         L4B0LNgq0vcgvyKsOcqIzeNrItWbwBBy/h+Poazwn7kVvNRbwV4w/DLuEtyZupNiZkp0
         gbSW9Cmp4duAM8LUAUhZ2+/rX7cxZA9o9fQwjqG6mWlrj4mBuIMSJzvD5sHWggh8P+Wt
         /6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWFO+40ZRiBheLBdNIkE+yF0740TF94kSrnELTjVAqX61tMBD6NMW+aBx3edPjcvk/8Omn5O0by5j+wxPR1rALqQ0Zt
X-Gm-Message-State: AOJu0YxKjgSELK0Kn3IrGi39fP4Vi3dIKinLagzJ+bOsqIg6p3M7IQ4H
	1Sq+iLLvBEc+u+AUprzroppSvd0WUaM6aEv/jzHGilNfiJR9toxR
X-Google-Smtp-Source: AGHT+IG/SqOru3ct+MmEJBVJW9C0uwJbPD6/FUYY1yIibHZAfghAgEeQmp17bQta1+G8SejUboDY/w==
X-Received: by 2002:a0d:f046:0:b0:64a:78ed:5cb1 with SMTP id 00721157ae682-68963707bf1mr130211267b3.28.1722867663617;
        Mon, 05 Aug 2024 07:21:03 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c864987sm35986376d6.110.2024.08.05.07.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:21:03 -0700 (PDT)
Message-ID: <4bb34106-49e9-45f1-a3d2-cab6329f2029@gmail.com>
Date: Mon, 5 Aug 2024 07:21:01 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] netdev: Simplify FILS handling in
 netdev_connect_common
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240805140721.57518-1-denkenz@gmail.com>
 <20240805140721.57518-7-denkenz@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240805140721.57518-7-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 8/5/24 7:07 AM, Denis Kenzior wrote:
> ---
>   src/netdev.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index fb095fdca561..494e46a59de2 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -3833,6 +3833,14 @@ static void netdev_connect_common(struct netdev *netdev,
>   		goto build_cmd_connect;
>   	}
>   
> +	if (IE_AKM_IS_FILS(hs->akm_suite)) {
> +		netdev->ap = fils_sm_new(hs, netdev_fils_tx_authenticate,
> +						netdev_fils_tx_associate,
> +						netdev_get_oci,
> +						netdev);
> +		goto done;
> +	}
> +
>   	if (nhs->type != CONNECTION_TYPE_SOFTMAC)
>   		goto build_cmd_connect;
>   
> @@ -3855,15 +3863,6 @@ static void netdev_connect_common(struct netdev *netdev,
>   		}
>   
>   		break;
> -	case IE_RSN_AKM_SUITE_FILS_SHA256:
> -	case IE_RSN_AKM_SUITE_FILS_SHA384:
> -	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
> -	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
> -		netdev->ap = fils_sm_new(hs, netdev_fils_tx_authenticate,
> -						netdev_fils_tx_associate,
> -						netdev_get_oci,
> -						netdev);
> -		break;
>   	default:
>   build_cmd_connect:
>   		cmd_connect = netdev_build_cmd_connect(netdev, hs, prev_bssid);
> @@ -3876,6 +3875,7 @@ build_cmd_connect:
>   		}
>   	}
>   
> +done:
>   	netdev->connect_cmd = cmd_connect;
>   	netdev->event_filter = event_filter;
>   	netdev->connect_cb = cb;

Mostly just an observation, but the switch block is pretty much just 
checks for SAE now, and the default build_cmd_connect case. It may look 
nicer to just have if/else if's for:

IE_AKM_IS_FILS()
IE_AKM_IS_OWE()
IE_AKM_IS_SAE()

But I'm also fine leaving it how you have it.

