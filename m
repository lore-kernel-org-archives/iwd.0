Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63118E76D
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128134; cv=none; b=H4UTYXSToig6wUwl+3FhjwiXZz4bOw7+qbeSyaj1x6m9leYXwEoAc3iMb6mwsanhtCsu4PwNHyn8pJyNQxvioR16nFPhpudRRgeFfO0BXJYl4VEPChA9THR0f/CMD5OcIpNArAFFVTsFPMMR+izAJflBowsCAXar1Ihu22keSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128134; c=relaxed/simple;
	bh=3hFTfNUoRtyEy3W1oUyouLOzDKQBlflpdIVEMdSzGuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T+2C1mDaZSMfGwPikol4V31bqGzoMcHZ8ZUPKmbN48xRwsZ6k/CPnb1khsc95FX6X0bX6uSyihBI/baToBJOQUaxCbwKFOmuEcspfx4tYByw9vxb47Eq5Hew7HUNpbo+KsjVCy8tnvkgQIIBe5Osj6gAf65YeSApbosLCrqScqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItFhiZuL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItFhiZuL"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70943713472so420909a34.2
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723128132; x=1723732932; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PS/aFmwTXamDihMC40CgdU6igb7HhZv2Gi/OeglM2YA=;
        b=ItFhiZuLsUuMtaq4mq4LP9YOfnryz96Jr3afJcaFcJR1qk7rjrAatKSx88UXVq0ydx
         qza38ctY9jUfQx/2mlgkBRYFFAlNmMdyu5CtBo+BpDYTTs6V0uFNSBt59IZAndH3dBpS
         Vby1j1QA5VxzfT0gEFQ0q8Z0wk0v+cQswfhLPuRuLrtpwIoMH6F0EmIi0NnMfR0Qa/nF
         XnjUDo6q9UrQb9cRE+QFX4W/epleYUr3zlebyfg5hJlIWxdQ8yEjazAjzKELvbz4QNMs
         X4Fz0sOvGiOJo3fCivtrHeVwfqsrkgDIb8Wl5n2HBhPQ1GYG9vSCd8EeIeAqykOUuZOq
         A0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128132; x=1723732932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PS/aFmwTXamDihMC40CgdU6igb7HhZv2Gi/OeglM2YA=;
        b=myt37rCycm66rXnkv+bU0+kWwW6sLoW9F8u5HDawj57FmppBAd7s6GGUSMc6qZQ24b
         RXRiNNlPDt8hfYAfXPlMocaKrLMlcOnZAqR2mdBl6mfQfG3BIIN2DxE6AFAWzbbS45lt
         wZQOxgwq+n/+Jmc6N1VeO6DDtBCNcblY9Zv7cd0RKOKRkVyQTukxwci5G40ntiwiwuOO
         JcmHoaA3Bm4KlYlr1J6KncfUAqjpEJUV8Lwd+rChISoqgkUvX4vn3YNDig3rx925+iwN
         4op90KfbQ9qS7Y6dol0FeyFFIel7zH0l/OKiRKxhWIWhzluBDFGtHMOLun1dlb44+swS
         S3uw==
X-Forwarded-Encrypted: i=1; AJvYcCW3/AJk2YtQ4sI5F5hMNXrjXfN1puNv+BVEjN0TKd2l1iwHWz1ap2WPxk9RHGfCik++2p5lYeRQXLyHthQxcCeJohEE
X-Gm-Message-State: AOJu0YzRBwcKoy+NsCdF0P7KMzNwglpAghDXQlBGGCjMrVyb1yDirK2l
	mf41DnIC/b5OJHf35jV666+erh05FkQECURWCglnsgbIiT009Ino
X-Google-Smtp-Source: AGHT+IFl263B0CuWvFipYywI0UHGFLh2PZQ+cjBRA8q8VdaUam/7CWnOFnXzPQioX7mKBqPVjbNKBA==
X-Received: by 2002:a05:6830:d03:b0:709:30eb:dfcb with SMTP id 46e09a7af769-70b4fc4c5a6mr2951072a34.18.1723128131867;
        Thu, 08 Aug 2024 07:42:11 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70a31d9dfc8sm5496168a34.5.2024.08.08.07.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:42:11 -0700 (PDT)
Message-ID: <91e6f683-dd0a-4478-afc0-f01f0f7f5d66@gmail.com>
Date: Thu, 8 Aug 2024 09:42:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] doc: document BasicServiceSet API
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240807181427.170515-1-prestwoj@gmail.com>
 <20240807181427.170515-8-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240807181427.170515-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/7/24 1:14 PM, James Prestwood wrote:
> ---
>   doc/basic-service-set.txt | 10 ++++++++++
>   doc/network-api.txt       |  5 +++++
>   doc/station-api.txt       |  6 ++++++
>   3 files changed, 21 insertions(+)
>   create mode 100644 doc/basic-service-set.txt
> 
> diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
> new file mode 100644
> index 00000000..2ebb63be
> --- /dev/null
> +++ b/doc/basic-service-set.txt
> @@ -0,0 +1,10 @@
> +Basic service set hierarchy
> +=================
> +
> +Service		net.connman.iwd
> +Interface	net.connman.iwd.BasicServiceSet
> +Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
> +
> +Properties	string Bssid [readonly]

Lets call this Address to be consistent with .Device, 
.Station.GetHiddenAccessPoints, etc

> +
> +			MAC address of BSS
> diff --git a/doc/network-api.txt b/doc/network-api.txt
> index e4a34411..3aa68382 100644
> --- a/doc/network-api.txt
> +++ b/doc/network-api.txt
> @@ -50,3 +50,8 @@ Properties	string Name [readonly]
>   			corresponding to this Network.  If the network
>   			is not provisioned or has not been connected to
>   			before, the property is omitted.
> +
> +		a(o) BasicServiceSets [readonly]

Should just be ao, there's no encompassing structure.  Lets just call this 
ServiceSet maybe? Or ExtendedServiceSet if you want to use the spec terminology.

> +
> +			Contains a list of paths of each individual
> +			BasicServiceSet object.
> diff --git a/doc/station-api.txt b/doc/station-api.txt
> index 05dd137e..7b067620 100644
> --- a/doc/station-api.txt
> +++ b/doc/station-api.txt
> @@ -164,6 +164,12 @@ Properties	string State [readonly]
>   			for networks.  net.connman.iwd.Network objects are
>   			updated when this property goes from true to false.
>   
> +		object ConnectedBss [readonly, optional]

ConnectedBasicServiceSet?  We also use AccessPoint terminology in 
GetHiddenAccessPoints, so maybe ConnectedAccessPoint?  This is Station after all.

> +
> +			net.connman.iwd.BasicServiceSet object represeting the
> +			BSS the device is currently connected to or to which
> +			a connection is in progress.
> +
>   SignalLevelAgent hierarchy
>   ==========================
>   

Regards,
-Denis
