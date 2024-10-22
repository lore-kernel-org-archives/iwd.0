Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFDC187864
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577318; cv=none; b=SWehLpQHhUFeSUJwAs6rKPEeVAEqCmwIDWKL+PmDxsX/EdP7QJGDjxA9cE6QKRFzpOBfG/MX6TexPE+m2ty9hiSAZH0Kq7vZtHbhebBV3izUaBlTFt0e+hQr6fdTeqCWhXSivqf+1LDipd+NPTxXifwsmoE2VgPBbqvKz3KXa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577318; c=relaxed/simple;
	bh=uaCC9iVeBfiSxiQ3x9uNucKFLiRTZwWUkpIwfz/B9z4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LwY/7noxAsOVnqtDoCVQgX3Om5HGlcZqYpIBOq6OMTUbhEpZC7nsoCYbxVeeq6FMZXqQ+qbuLD/JN5x9dQP83yrqq/REJ00MVjj/oNIiq22Cl1PN9grY3R6frX2U8uQeRFjtU7WH9FUAeUOnyKCOACyjNzymlDmgraHLWAR1kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JjB8+q/+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JjB8+q/+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1418058bbso400982985a.3
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729577315; x=1730182115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHTKqiGmx3Z52TvFoL46bTukd/R3bDyeUriG38zYngk=;
        b=JjB8+q/+lHp9LnvI57hnK3iG78w79a0JAx/bTggSWODS8qYG6zGiYvMijYuLz19kqZ
         ksvcDSoP2GA5yX0+p4pVvCLdZwM5KMFtzLG3kDPRdE+sSuHtIMS0uu3fX3HrTfPk9rDu
         rVTVAPRTnefzgjfUUKxXJGZgLMl8kVvVmiiOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729577315; x=1730182115;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHTKqiGmx3Z52TvFoL46bTukd/R3bDyeUriG38zYngk=;
        b=awt7CgwsTCxpkEActNkWzOyqdodAKSf9jEpLptB38+IqBwjbQiZwihhFH89YkyLIzj
         TaPnKPu/Dy+VSFw/qgzkz0y5bvNfHJQ5oFe+0hKkmLZLWKW7hNaCNcRCnbHYsc/IouVF
         gW5HX2l3/KPubxAGXgZy8TfWXz/UramZCB2P4IM26SDhH/mfJWW/FwYHcXmS/Pw3Sj9u
         4McQqcgtPH8sKlrD3Uglgv6abZfbEJwULv+QaBXqreQJe99MLHSzUmQo2UgXLrEzpblI
         fR9mRosKjvqRI/kb4BsqEa0Uar/awD99+LrH8cnFTq67pHFjo9XpkZIoqwhERh8m/7Ms
         Qwaw==
X-Gm-Message-State: AOJu0YzIDtCwgkh4086p/gi3jo/aN12+KTPolvfc+9DNE1HzKJXza78P
	yeeC/Pzy+Z/sDzoxqjY06tiiaQ9nCIu9c2m5U3Z6Eks98FkUtzNdxbdZ/PxbOQ==
X-Google-Smtp-Source: AGHT+IG+xKhibh3c6jz29XNy5IwMeLxheB9Hv8Meie8B8mEGpDF81ROYnSMRNrKzeqTYlGFvulj4XQ==
X-Received: by 2002:a05:620a:1998:b0:7b1:465c:ce2 with SMTP id af79cd13be357-7b157bdeb70mr2018914585a.52.1729577315118;
        Mon, 21 Oct 2024 23:08:35 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a78cd9sm247746785a.111.2024.10.21.23.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 23:08:33 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Martin Petzold <martin.petzold@tavla.de>
CC: <iwd@lists.linux.dev>, Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Date: Tue, 22 Oct 2024 08:08:28 +0200
Message-ID: <192b2d74f60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <c432d58c-d0a0-4887-8b95-01a65bf096d6@tavla.de>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <c432d58c-d0a0-4887-8b95-01a65bf096d6@tavla.de>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 21, 2024 10:23:08 PM Martin Petzold <martin.petzold@tavla.de> wrote:

> Hi Arend,
>
> Am 21.10.24 um 20:26 schrieb Arend van Spriel:
>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>> Hi Arend,
>>>
>>>>
>>>> I have not seen patches for OWE in brcmfmac. Looking at the
>>>> supported ciphers:
>>>
>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>>
>> My bad. Always confused by those concepts.
>>
>>>>
>>>> Supported Ciphers:
>>>>  * WEP40 (00-0f-ac:1)
>>>>  * WEP104 (00-0f-ac:5)
>>>>  * TKIP (00-0f-ac:2)
>>>>  * CCMP-128 (00-0f-ac:4)
>>>>  * CMAC (00-0f-ac:6)
>>>>
>>>> The error message seems to match with the above.
>>>
>>> I've never seen support for OWE in brcmfmac mentioned.  OWE requires
>>> CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the
>>> PMK, so iwd can't support it on FullMAC.
>>
>> I have never seen any mention of OWE either. Regarding
>> CMD_EXTERNAL_AUTH support I recently posted patches on linux-wireless
>> list as RFT. There has been zero feedback and so I assume also zero
>> interest. In order to use CMD_EXTERNAL_AUTH the firmware needs to
>> advertise "sae_ext" in fwcap debugfs file. So if Martin can check
>> that, ie:
>>
>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>
> I have now used the eval board (same kernel, different firmware). Is
> this possible (nothing there):

You should check mounts:

$ mount | grep debugfs
none on /sys/kernel/debug type debugfs (rw,relatime)

If it is not there:

$ cat mykernel.config | grep CONFIG_DEBUG_FS

If it is:

$ cat mykernel.config | grep CONFIG_BRCMDBG

The latter enables several debug facilities within the brcmfmac driver 
among which additional entries in the debugfs folder mentioned.

Regards,
Arend

> ----------
>
> root@imx8mp-var-dart:~# cat mykernel.config | grep CONFIG_DEBUG_KERNEL
> CONFIG_DEBUG_KERNEL=y
> root@imx8mp-var-dart:~# cat mykernel.config | grep CONFIG_DEBUG_INFO
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_NONE is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> root@imx8mp-var-dart:~# ls -l /sys/kernel/debug/ieee80211/phy0/
> insgesamt 0
>
> ---------
>
> Martin



