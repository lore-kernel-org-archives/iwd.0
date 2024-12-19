Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB83197552
	for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632328; cv=none; b=AygeSnyH3vjINcHU1t2DiYjXxcXhTYJMPi4kf9ltk1o8Zu2CZ97Nl0792Kx5cxj5ZaRURknWSfy9w+Uwb9DF7+Jm/mRwjDkoZYAgFvn3GWHNTEvi63WyvYBZuP0M9u6WfpL7Q2yRoEVqSJyRoYetE92O/m6XS7ejDYN2jC+1iQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632328; c=relaxed/simple;
	bh=E43dNBmy8EQ8ufh1Zp8H56+ambCT02mU50P2Z1uwU+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=USUnAoSzVIK4+/ds4XFZMSKcFDEuhi2AoK/P+WxqeehFz10SrcSpY27hiFAVis9jQvekRbwbTE+Jix+KsGacNaxJQKvrNde+TEbQd7erbFy9cD4mHHjef+GHcVGBLa6ePxYypGDRfTZOPGdB71sbZqW+e1U0OL9ybn5qYUmEjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ8oDjkM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ8oDjkM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728f28744c5so1138725b3a.1
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734632326; x=1735237126; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHUwRLWkgokHVrMX2bB9vnG5lkPV22Tu1YzgK701NdQ=;
        b=kZ8oDjkMLuLNvE7dT+uMcG/kj3Wxw93qdaZ/MuYxYJ1SfymoyvZ0Lc4QpKTvML/dkZ
         lXuGmsa7KBaeUrgtF6wM2KKY+PdF03kLKzo9Vr2KOaRL/m5TeHBPgjnHllG4FcrTweJ0
         3A3LflL5DUyAu33yNqM8DdPuixLB1pOBby49aqBGxeNR/D5K4qfU47zCsEIFNWkBKV1D
         vF3ODBjRwSEgBQkt44hS8Ga8q3LIIOyVMo7i+g69MVa6wKB5eJcLTLzfgZpXP+Tu6bWH
         2ytiNmgRfmJ5gzgcEMJ067FmgOi44iBxR/NjkYMNhDOofdLWm6BFZBXUrQuVG1EpjZT6
         t1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734632326; x=1735237126;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHUwRLWkgokHVrMX2bB9vnG5lkPV22Tu1YzgK701NdQ=;
        b=CRgdtxl6YCp5a4rlOKIIJmK0Wm6zxpzN+roFVK5MMsZpsdqJRo9bLGbMgQX6ZWgnox
         8R0qgx18NAkRatBmQaadRCPr8G3Hab0awQ2wsiwafC8wTQM7dpwN0BdqnIFFjolJxY72
         sr+vmMIbeyv91B2oLCwPqwcbHHoi7w7AkaFsUZDxQZXZjl6M3gw+YBbHHYCIXnrVwEul
         X0iMBZMO4p9T8Jf2OLrdTMvPgDv31T0K2ME93lwaays6SorF5ZQqEvgojlndG49moQsk
         6i+Z43/nh9nOiMaeD8E7lSSevHzTv+bTh8XIUWbEdl2jO5ah/4KvEXK4OASIhX+A94vQ
         +FEw==
X-Gm-Message-State: AOJu0Yw0XQrdd+ALXTRyC8ZgW3BucEuj08oUkhGzb81XKUVouh4Btlwy
	luGFpw7s26G8qi8dbQFc8U1ari79MgITGPiGBXvf2uf2KkIwq/i3pS4+qg==
X-Gm-Gg: ASbGnctfarFJpt6baFwX+EJdAteDtb+FSwqhwB5sR7fIIXfoP0picNO5E8DqWm3ebD7
	Y/6SZCTA+8S/RTdm9ndOcDIdkDnUvayIsAjqh//vsq8+tj0c4rLkj9itjTfnmvjxuVE7Z2cpnYp
	xSE9LQLWshwBtgKk3thG6sJuSAF01VDquAPKz60KNmFkGg4eRYqIech6S+Tky1J6DfqdcjP74jW
	CAFO9PdVNVX1jz2mxwbIwk2Qis/LwSS0GX0TBj973EhLyr2kwU49IbTe7bI
X-Google-Smtp-Source: AGHT+IE/l/H11o5bTjv7sghOCIP7knowEyXfMAplZfaNq22tqhN8BNxssnaE1lSSIF728Wy4wFSuEA==
X-Received: by 2002:a05:6a00:23c6:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72a8d234562mr11170453b3a.6.1734632326319;
        Thu, 19 Dec 2024 10:18:46 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd2bfsm1660912b3a.148.2024.12.19.10.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 10:18:45 -0800 (PST)
Message-ID: <ee05cb0c-d317-4bd8-8736-6ffaba6d7b62@gmail.com>
Date: Thu, 19 Dec 2024 10:18:43 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: destroy auth-proto after external auth
To: iwd@lists.linux.dev
References: <20241219181701.164349-1-prestwoj@gmail.com>
Content-Language: en-US
Cc: KeithG <ys3al35l@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20241219181701.164349-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 12/19/24 10:17 AM, James Prestwood wrote:
> With external auth there is no associate event meaning the auth proto
> never gets freed, which prevents eapol from starting inside the
> OCI callback. Check for this specific case and free the auth proto
> after signaling that external auth has completed.
> ---
>   src/netdev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index 02496c92..2a6d94fc 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -3483,6 +3483,13 @@ static void netdev_external_auth_sae_tx_associate(void *user_data)
>   
>   	netdev_send_external_auth(netdev, MMPDU_STATUS_CODE_SUCCESS);
>   	netdev_ensure_eapol_registered(netdev);
> +
> +	/*
> +	 * Free the auth proto now. With external auth there is no associate
> +	 * event which is where this normally gets cleaned up.
> +	 */
> +	auth_proto_free(netdev->ap);
> +	netdev->ap = NULL;
>   }
>   
>   struct rtnl_data {

Could you give this version of the patch a try to verify it still works 
on brcmfmac? This is just a bit simpler and more straight forward.

Thanks,

James

