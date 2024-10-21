Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8F2E628
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524196; cv=none; b=MbNE6OsD9kxXPDXAsbuQ9Vl5XSfZ1w43mGQiyAzBOk3yF+1qGT0zpnYjALIrtMSNncWOHSz6PgpYFhR5U1IpnwwpSiTmntU1gdOFZV9POV7jbWqWGQP/RpfvmBzTdzWBp+zu/jlRJWI9jWWa0cbSV6lBKsrlbyOSy9NetDaL4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524196; c=relaxed/simple;
	bh=INPYv8+tIp2cFhSeTl9wiY2oYIHY1qkvr8OGFkpkJ8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqDqOwbON1ylqWg4Kvm3+5sbfOL+lzuqk4/4VPPioThVMAwNy7Yk1N9bw+dinNz07NMFkAM5SnH207VPuV3BRO2+p6wmz+4a4g6jjgMHeAn3hPQ/BlvCj4T2DfrRw9SRU7o5cakU4BoosJu29Z7KrLM2eAM6DqR1N8d4xm27u9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLitnwyd; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLitnwyd"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc1af8f10so482250eaf.2
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729524194; x=1730128994; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7M8mkQ5mUesAQbI8xtVId6p26Wny/ElDGsOso7sAT4=;
        b=YLitnwydb8waDZ37iPNmPNkyaSeEzxmiXZuZxmPK6oHGx197WmOeibW5gBNWtnLrRf
         JjWc6pMzuM8rJUc+v/ROYdfTetdqZI/O4YdN0LCRWfWuGPb5H/lJV5z9y4wNvYbl8kiB
         RIiTxY9e1OMYcDwkYMk/Ewbhss3lIGwZF7AdQUV2nYUap1Yax3mDhK0/sB87EnJxqirk
         1jmdOK6zkWTtgJpWk4ew5GKFQ4J7rd6076XAFaiqNADMHCOH21zTtX3TWjiR4dc6H9xB
         mwdY+9iWB7F2GuKWgjzC6tQ80Yq6ANKuOK6GNERxUfBVynSG4V5id+hpVmWxPc2LTrri
         3EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524194; x=1730128994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7M8mkQ5mUesAQbI8xtVId6p26Wny/ElDGsOso7sAT4=;
        b=A24OBbE/Ag+WjB5Hfx2y8RjxwEO7+1jq+scGRI1NXag5/htijk6EEt4oUD9bfH161M
         4+6RzL4f9P8W1Ued9B/9uzN/ysgoA61evv1c2SGQmRuwTY9VR9N25EFnjmOR229BC2El
         UvY1bd0n2V/5uKABVVM71ji7G9uTTrZ2xb/c8R5EgfoY3qdnSJB98RpzleRuDIzrZRhg
         F8ektS6b6Kt8Sdkuxh5+ZWb2yuv0qI8Yvyzvg9TAJZA4xEvoBmMkj6Z86+C0pAmX7xjb
         TcyOV5KIwPJqLaxoKwbvBVKU5Zl5Jx3vyxqNPzPEoCfJG8FE796MfPdB7eyrfSN68gTj
         9QHg==
X-Gm-Message-State: AOJu0YwJ4YEMAGXxkSMh+SUDGAXPKdIkp1TTwM/QvD80FM/li++oyp5u
	iiExKoZeeFZeiQZh8UufKR9M55Q912AQ6L0Idvqwd09mE4Cva5RV
X-Google-Smtp-Source: AGHT+IEyY9ckIgvHLy225/TpBYrP8cA8fhIdtdLtuEUazNzTOp4everqBvNuQdbYTkvMvqZ1M055qg==
X-Received: by 2002:a05:6359:4593:b0:1c3:9cf5:2866 with SMTP id e5c5f4694b2df-1c39de243a9mr356062455d.6.1729524193897;
        Mon, 21 Oct 2024 08:23:13 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999f2dsm17915116d6.102.2024.10.21.08.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:23:13 -0700 (PDT)
Message-ID: <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
Date: Mon, 21 Oct 2024 08:23:11 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Martin Petzold <martin.petzold@tavla.de>, Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arend,

On 10/21/24 7:40 AM, Arend Van Spriel wrote:
> On October 21, 2024 3:34:46 PM Martin Petzold 
> <martin.petzold@tavla.de> wrote:
>
>> Hi Denis,
>>
>> Am 19.10.24 um 16:41 schrieb Denis Kenzior:
>>>
>>>>
>>>> This is a more or less common setup for embedded environments. Would
>>>> be glad if you could double-check if this could cause wrong initial
>>>> connection (weaker AP).
>>>
>>> We can't help you unless you provide logs.
>>
>> We are now in an enterprise grade Cisco roaming environment. Initial
>> connection to the (open) network was possible and routable with
>> connection to our servers (!). However after like an hour or so the
>> connection was lost. And then re-connection was NOT possible (both
>> autoconnect and also not manual connect via iwctl fail).
>>
>> Please find attached the log output: logfile_tavla.txt (with brcm and
>
> The log output is not hard to read. The brcmfmac indicates it does not 
> support the requested akm suite 00-0F-AC:12 (Suite B 192b).
This is actually the OWE AKM. The last byte is 0x12, not "12" in base 10 
:) Does/should brcmfmac support OWE?
>
> What capabilities does iw command show for the wifi device? Maybe the 
> driver announces something which the firmware does not support.
>
> Regards,
> Arend
>> iwd - no debug) and logfile_tavla_debug.txt (iwd with debug and manual
>> re-connect attempt).
>>
>> I have now enabled "--debug" and it would also be possible to remove the
>> network and do another full reproduction with initial connection.
>>
>> SETUP:
>>
>> SoM: Variscite DART-IMX8M-PLUS
>> SoC: NXP i.MX8M Plus
>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>> Antenna: Laird FlexPIFA
>> RootFS: Debian bookworm
>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>> Network Daemon: systemd-networkd 252.30
>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411) + ELL
>> 0.69 (7bed251f8020ef896043f008276f41cd13fdd43f)
>>
>> KERNEL:
>>
>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from
>> https://github.com/varigit/linux-imx)
>> BRANCH=lf-6.1.y_var03
>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>
>> FIRMWARE:
>>
>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>
>> From:
>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/ 
>>
>
>
>
>
