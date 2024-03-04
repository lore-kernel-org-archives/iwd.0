Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2693C46C
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555014; cv=none; b=uJhBpbDDL2lduXpO3WuwjzACXOYAdQQb+4yyRvMgnpDBViqM/2Q+JqnOExJfU8khStrAfCef3idxHCzBvcshNW539LuWfNySHW+ggVUMRHf8VpH5y8pE2RO5TfNtq7FOfumxhGdVduNwp3D5CEPevPClUMjIzC8eQ0sPxzPs4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555014; c=relaxed/simple;
	bh=BmcyT3j3lwbNzwo0XAeAfxLJBhcBmpVkSQPKUUKRVeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OFKdGY2kPN4sJoWL6KSsl7/YqbxeHYEwFAI0oFEikkVErtQM8oAz3CuO9Ma+n5lQcfCa3XUhujO0lTjaGuyaGKzT/1E4aoDKJ+11z7uE5aexBUpPsw9VRVfpUNAsECPN7QiDnhv/7+2fLxAvdf2JcRWjCuFgTfJ/NGzPUuUz6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFoDpyDn; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFoDpyDn"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e4a0e80d14so3299320a34.1
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 04:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709555010; x=1710159810; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQrQ/PEbIzyBEuJSb/1MAnX9+xF/XnwvDFqNyUHj5Es=;
        b=CFoDpyDnWIWzOegSKGF5i01Fd85vuUqo55+Zg40g7EnqqrrKLySKOpnclXkbnCiOMa
         9ptubB9DBGpfaIBqRI+vOqQmgnmobgd/DCcWf6yq9Hml7bEIys/+tjVdbHXqXuJghhVR
         q1ZnYQjDmPHkZQ18gfn76B/f+cAGPwqwNjOuLNLV36HnANDF1hAj+ZQ+ForkpfUk2exf
         KwbHbJp3MSt/ZewDUv9wQkf4r13qwZtWgI64xYCMkRAj9mbeEc0uhytOLG+VhOtaoaw6
         Upr/vLEVQKgaRvV+Xv7OwDlqBXWgCCScvLED8p746HKy6JYncMmLEPw86efPheaPT3N9
         GsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555010; x=1710159810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQrQ/PEbIzyBEuJSb/1MAnX9+xF/XnwvDFqNyUHj5Es=;
        b=Wo873whx3qKDGMgxDWhBtFd5zK20QlFecACWsZg/hHmVKLGgkEmnnSykwKeGyJ/zHX
         UU85va0VUkJ7BBJi2+VASd8GVoRU8q03+daOTIU5IF/TUcOJX4HJo64gWrx+jBx+5njI
         f70KAMelO5XMHks8KITvxSk1uSVYLuYm1N/Sh0r/G2J1RxFl2JCfrPnLJP35vblz1J1J
         hNzimEmhT+M57IiVvECys8c+galSitlDrD5zvSC5LpbYeHKfe8a+Gqihva2qvn8ZNPnN
         NuOS8hELpspbobrzm39EdjbhuVAftC1YkxFs0WVO1cWVKAH89BnOfY+IU96gn0uUTfCt
         nfLw==
X-Forwarded-Encrypted: i=1; AJvYcCV0QfJ4lWv8UOd9Z72TdvN8Jy+QxPWfSMtSc3kA2rEuOM3FLT5kTJnjU0TG4h55oSUWmwRqT+9c+ufCXQGMxJUHGG0Y
X-Gm-Message-State: AOJu0YxAlcEsvwFfetH+fWmEf+km/5pv6FuGeMZMeGNA0Vd2LWUyG+i3
	ghUBQEdc1nLszXgMpzE+ZpaiZ6GriUAW3qkJyc5GuWBLaqSetlgz
X-Google-Smtp-Source: AGHT+IEESJT+msIzky74BMuihMPydDb8F/MZnX3PoxC2UaXylEWZQmFIXXDi2gt4i22XKVX0m0RuTw==
X-Received: by 2002:a05:6870:9f89:b0:21e:df12:9499 with SMTP id xm9-20020a0568709f8900b0021edf129499mr8897520oab.51.1709555010204;
        Mon, 04 Mar 2024 04:23:30 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id vr1-20020a05620a55a100b007881e40ce0bsm1948206qkn.83.2024.03.04.04.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:23:29 -0800 (PST)
Message-ID: <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com>
Date: Mon, 4 Mar 2024 04:23:28 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to connect specifying the BSSID?
Content-Language: en-US
To: Kentaro Yamaguchi <kentaro.y@gmail.com>, iwd@lists.linux.dev
References: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kentaro,

On 3/3/24 8:31 PM, Kentaro Yamaguchi wrote:
> Dear iwd users and developers,
>
> With mesh, I would like to check whether it is faster to connect
> directly to the child device or the parent device.
> Therefore, please tell me how to connect using iwd from the client and
> specifying the BSSID.
>
> According to the comment made 5 years ago at the link below, there is
> no way to connect by specifying the BSSID.
> This has been answered, but is the situation still the same?
> https://bbs.archlinux.org/viewtopic.php?id=237074&p=5

Yes IWD connections are SSID based and IWD chooses the best BSS based on 
how it ranks.

For testing IWD does have a "developer mode" which lets you connect to 
BSSID's specifically but this mode isn't something meant for 
general/production use. But if you only want to test one vs the other 
you could use it:

# Start IWD in developer mode (-E)
iwd -E
# Scan first (developer mode doesn't autoconnect)
iwctl station wlan0 scan
iwctl debug wlan0 get-networks
iwctl wlan0 connect <bssid>

Thanks,

James

>
> I tried the following, but I was unable to connect due to an error.
> I know that using wpa_supplicant as the Network Manager backend will
> work. However, in that case I would like to use IWD because I have
> problems with 6GHz connectivity.
>
> 1. Specify iwd as wifi.backend of NetworkManager and restart.
> 2. nmcli device wifi connect [SSID] password [Password]
> 3. nmcli connection down [SSID]
> 4. nmcil connection modify [SSID] wifi.bssid [BSSID]
> 5. nmcli connection up [SSID]
>
> Error (from journal log)
> -------------------------------------
> Mar 01 16:38:48 livazplusNetworkManager[1408]: <info>
> [1709278728.5365] device (wlp4s0): Activation: starting connection
> 'Buf-MLO' (019cd427-8f11-4c84-9625-db03895b510b)
> Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
> [1709278728.5367] device (wlp4s0): state change: disconnected ->
> prepare (reason 'none', sys-iface-state: 'managed')
> Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
> [1709278728.5370] device (wlp4s0): state change: prepare -> failed
> (reason 'none', sys-iface-state: 'managed')
> Mar 01 16:38:48 livazplus NetworkManager[1408]: <warn>
> [1709278728.5374] device (wlp4s0): Activation: failed for connection
> 'Buf-MLO'
>
> My environment is below.
> --------------------------------------
> Lubuntu 23.10
> Kernel 6.7.6
> IWD 2.8
> NetworkManager 1.44.2
> Intel BE200
> [    5.297551] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> Version: 0.0.4.125
> [    5.302086] iwlwifi 0000:01:00.0: loaded firmware version
> 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode op_mode iwlmvm
> [    5.764947] iwlwifi 0000:01:00.0: loaded PNVM version 8443a58d
> --------------------------------------
>
> Thanks in advance!
> Kentaro Yamaguchi
>
