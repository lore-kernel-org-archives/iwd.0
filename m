Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D91C9ECA
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568509; cv=none; b=bG+/Be3olqwxBRNiLQ2ij5valJ5rjGbcFVznz08GXFW/0m8Si+/OH33FIUmcJXPw+IxDsaGRM1gD9UUAYl+P92DmtHIdR+u3xsY/vSOzseH2Ttr1itdMuxzG6XicePS/+aFrsRaJyIQnJY1mrfS/bXRZ9OqhRHMETGWl97ng2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568509; c=relaxed/simple;
	bh=QtvdSBJfJ/lpVDA7j6/iqikANoHTRRpIbOL3bWImXrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tleQz80ckZYZZrAZTqeFz0cfsSpd5a+LYezyPMYn8UsCDU5xFyR/y/aZU0dz0qK032UWpI9SXprQ2FTlkLYXzhQewEYfOrV7V/VqzSshIct3hdng/8CBGBLMxehWkjSkC3reEREiblf5hl/RikQNuQ3uXyWw6UbG/4VSed4ACuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkTiFGC1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkTiFGC1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4603b835a1cso10797521cf.0
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568506; x=1729173306; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpsxOKORVRkx6xkgvtFvFdTy7/gl82B41lMZoszUHQI=;
        b=SkTiFGC1iwuGyKuoFZX/dkEL3qkmf0MkqjpvzgRsJAk8CfZtlYWkqAIbRpkdFNCp2J
         X/YGS2ehjXTAM3V+oqGQTaQMwMUkq9/F2rJmxkkjWt8Ea5qSBhDoa8dpy0K2/obd+wOz
         8YoW6V/5EsEgstoiT6t+dgxBc6/8bALucuxuAkeTlqDYDbAv/7EdVs2HzqLOpJof6jhl
         cncIKPdyK8Fd2oYh+9UmFrJBDWg+IXwhjMWe88P3jBrsnM0xQLJPXvLLKZTY6zHaH1Cu
         xb01RHh8GMNcTgPUasWQH7nIaCtpdaKVIfiDWAMdDUJ9DZ2vHGJH8CK6C40ms5QwYTst
         2uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568506; x=1729173306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpsxOKORVRkx6xkgvtFvFdTy7/gl82B41lMZoszUHQI=;
        b=QPcrsQ93PjZ2alf8vDZ8lRggAg9Ux+rqNlDfzUeXNXQVfLCtYVFypN7CLYhYXqqfmF
         CnsBdzUnepL1tg2KQnGiDsNSG7cK8IkhvZYXu51TZRDAFlVgcpug912c90ivzSXIMRpI
         woHVXPZp0zj8x79Aveg7ahqPQBwMn0oYsx/XKSs3JHAmRTC8ydm8UrJPN7rbvOKROqtr
         YF38geoorxJAkNhc9k8FIb8si2wJHfLFMFgQ6udIsKPP4W5/C1A7mLZoNesR+M7QkQEd
         wNHI8eZhn/ko/s72j3P3WGKT3xh4EhhX1bKtJJVpYQrfE13MlPiI7kaeABTC0+yanNJv
         R7Lw==
X-Gm-Message-State: AOJu0Yw7q5v2kkxSi8qYlv5WS+GL/n2DWYxeg89t41LWSD8YabC9tXCv
	V6b51VLehMTkAnLAj6Un67Y8Qwj+SiLGHgCnSgQnMhqCVhsDQb3q
X-Google-Smtp-Source: AGHT+IG6WzypTAcgwe/1ANyvJoQSgzVscuhA9ftDVldJ4+DSQQx1JtAXKCgaHsAttLk+aX4bWhTQsA==
X-Received: by 2002:a05:622a:1f8e:b0:458:3a65:1d0d with SMTP id d75a77b69052e-45fa5eca56dmr104849781cf.6.1728568506509;
        Thu, 10 Oct 2024 06:55:06 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d50efsm5581981cf.22.2024.10.10.06.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:55:06 -0700 (PDT)
Message-ID: <b6f570d9-c14d-4e71-87a7-3e7d2c2fd6ca@gmail.com>
Date: Thu, 10 Oct 2024 06:55:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <74af8f9e-b5dc-41be-998c-45bdd5958bbd@tavla.de>
 <154ebbba-2a3b-4f65-8b21-41dcc93d2107@gmail.com>
 <1fcf76fd-85ab-4a31-8aaf-9d6922ab3a97@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1fcf76fd-85ab-4a31-8aaf-9d6922ab3a97@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 10/10/24 6:47 AM, Martin Petzold wrote:
> Hi James,
>
> Am 10.10.24 um 15:36 schrieb James Prestwood:
>>
>> On 10/10/24 6:20 AM, Martin Petzold wrote:
>>> Hi Denis,
>>>
>>> Am 09.10.24 um 18:07 schrieb Denis Kenzior:
>>>> [...]
>>>>
>>>>> 3. Build IWD 2.22 from source (maybe using Debian sid source 
>>>>> package?) -> how to do best and will this work with libc6 version 
>>>>> 2.36? Missing libreadline8t64?
>>>>
>>>> I mean this is your only real solution.  There is no 'long term 
>>>> support' model for iwd.  You either run the latest or you're on 
>>>> your own.  It is highly unlikely that any of the developers will 
>>>> look at logs (or attempt to fix) anything but the latest version.
>>>>
>>>>
>>> Why does the following build fail. I did not install 
>>> 'python-docutils' package because is is not available for Debian 
>>> bookworm (only a source package). How should I proceed? Maybe the 
>>> documentation should be fixed then for Debian bookworm.
>> You need to use an updated version of ELL. IWD and ELL get released 
>> in tandem in case of any API/behavior changes. 
>
> I used for both git HEAD repository (how can I get both in line?):

Sorry, I just glanced over the error and assumed incorrectly. It looks 
like -Werror isn't enabled (?) so that warning should be fine. But the 
issue, as you said, is docs related. You could try to configure with 
--disable-manual-pages

> src/eap.c: In function ‘eap_rx_packet’:
> src/eap.c:419:57: warning: ‘vendor_type’ may be used uninitialized 
> [-Wmaybe-uninitialized]
>   419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && 
> vendor_type == (t))
>       |                                                         ^~
> src/eap.c:429:18: note: ‘vendor_type’ was declared here
>   429 |         uint32_t vendor_type;
>       |                  ^~~~~~~~~~~
> src/eap.c:419:49: warning: ‘vendor_id’ may be used uninitialized 
> [-Wmaybe-uninitialized]
>   419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && 
> vendor_type == (t))
>       |                                                 ^~
> src/eap.c:428:18: note: ‘vendor_id’ was declared here
>   428 |         uint32_t vendor_id;
>       |                  ^~~~~~~~~
>   CC       src/eap-md5.o
>   CC       src/eap-tls.o
>   CC       src/eap-ttls.o
>   CC       src/eap-mschapv2.o
>   CC       src/eap-sim.o
>   CC       src/eap-aka.o
>   CC       src/eap-peap.o
>   CC       src/eap-gtc.o
>   CC       src/eap-pwd.o
>   CC       src/simutil.o
>   CC       src/simauth.o
>   CC       src/eap-tls-common.o
>   CC       src/mschaputil.o
>   CCLD     src/iwd
>   CC       tools/probe-req.o
>   CCLD     tools/probe-req
>   CC       tools/iwd-decrypt-profile.o
>   CCLD     tools/iwd-decrypt-profile
>   GEN      src/iwd.8
> Generated manual page src/iwd.8 does not exist
> make[1]: *** [Makefile:4106: src/iwd.8] Fehler 1
> make: *** [Makefile:1746: all] Fehler 2
>
