Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF11E0DA3
	for <iwd@lists.linux.dev>; Wed,  9 Oct 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490037; cv=none; b=ghBe2hkURWZ/DtlI9sOmxY9X95ZReyt3cb6rPHAEzp3n+mwBqCVEyDjKR8/yFzd4rPrqQBgUlttA0s89SIQ2xpnsvWT6pHdx5K0MvYd4KeVa6p8Dg8W1lQytAYOHQlWD5Co4pDXGKKwekeFzV11dQSZmVWxt1ixbmMs56tjvEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490037; c=relaxed/simple;
	bh=ToNoUwiQ0i2ninij8W9KkfrG5TTjItnw59gJI4ZI6tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hpVrqCcCzZUFwpMVSeMXOf350W6civQt0rus1dpjh3AJrURRqtNpLZzC3EZvvtRNWrxgXPCoIpuO80IB97cq7c12RF9jCSe2A2nqqaomluC3DA2eYXv+06lBGcDV3GnFROQKnVbdAR2dhp7/mxC1jrilgi+Lp17wtyptXDOmSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEiGG00M; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEiGG00M"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e7aec9e168so3687646eaf.3
        for <iwd@lists.linux.dev>; Wed, 09 Oct 2024 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490035; x=1729094835; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2894Ij0RWKI/hRKA2fsU/4FK+IcL8XNdJTLPDj3y8wI=;
        b=nEiGG00MEPEkzZjV6HxlDx/VXGcBEg73UE4wFcsqk8nDrhTt5Sh8qIV7FmMt5OKu6A
         hK4S1iz1bKA3wOzbnnE1cPCHU7Ja4r4C1AZ+0xfGZVcyizkAL6QWbcrWIF02J3agvHXb
         Y6/8rIzJSgmRzhfuYz6Kiee16/T9wlTlXtZ3UJFhxn1h8hl1QIK6+1VanTKqSU27xF3K
         vPkRUP3Hf8c89+8IQIMmqzZnPfIlUiKedbExLJ0OlVj3p2uPTRH08A0grT9LbxxyHToD
         BwyLZWBrSl6Ul+3zf9/+jfCV/EncArrcoFZ3mFdIW2O91EtZkjSP68uB379i1oPqdwoH
         IDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490035; x=1729094835;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2894Ij0RWKI/hRKA2fsU/4FK+IcL8XNdJTLPDj3y8wI=;
        b=SstNIX0MTPJjF1asOVsyHd/3Iru/gTy7JNqCOj1RsPTqPjy2NA3jza7BP/tEFlDJaX
         XYzFjwehrZtu5GCOqQ6m7uV3s7NKgLHN7+U6tRs4KAV3A8p4PhYAcHAGWSbP7/f5ZGBm
         qpPB59yJPSbEtd+LA1b7Ueb0iIglzTFQIQLVQqo6SuQKCeHvYKTLJ4ArJRHEPtnMxVwm
         2RzscKVlt/4U+iERC3dVOlEcJQA97/zZZXc9esTQDnOEXAdiV7B3q70kwjNB9rLeyoq8
         vHv2eLS7Hrpxcy7yD+BPeQxFU39PE4uVzfM2NfH3XRlo75Zyu4BKJTfwIyfCkYC0ZFIT
         k/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUi1ij5gcz1PlOG1o2V8hINEEIoREXTv/4ja6QnIDYOGuC1BdivPrnPZ9OxOjfkNLTHvTc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDyQRcTh4TBZCT8cQCVfCdAUpDmQpLSlQOJGOHqVzKNBvFICNY
	q8+20vxGB7JKh1qiz19vPLtxn/h00fmCpk7jkjMT+rkpGJa6oGwI
X-Google-Smtp-Source: AGHT+IGVka9VjBiTKz/KtIAIMQORLwYa86k5aE0b1mmSZz0br89S6YB/bqTaONoERW8PM6yq/JNR9A==
X-Received: by 2002:a05:6820:270f:b0:5e5:c489:6f3c with SMTP id 006d021491bc7-5e987bc9df9mr1692123eaf.5.1728490034537;
        Wed, 09 Oct 2024 09:07:14 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5e862e4e2d3sm469799eaf.25.2024.10.09.09.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:07:14 -0700 (PDT)
Message-ID: <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
Date: Wed, 9 Oct 2024 11:07:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
Content-Language: en-US
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 10/9/24 4:43 AM, Martin Petzold wrote:
> Hi
> 
> PROBLEM
> 
> We (still) have some trouble with IWD together with brcmfmac. We updated 
> firmware for the chip (Infineon CYW43353) to latest version 11.171.0.24 and also 

Ugh :)  That stuff is known to be problematic.  You might want to involve Arend 
in this discussion.

> IWD to 1.27. The situation became a lot more stable...until we tested roaming 
> setups. It seems that for IWD 1.27 and maybe also later roaming is completely 
> broken (at least for brcmfmac). It does not connect (No suitable BSSes found) or 

'brcmfmac' -> Full MAC.  Full MAC implies that all roaming is handled by the 
firmware and iwd is not (or hardly?) involved in roaming with such setups.

> it connects but with wrong AP (poorer access point) or it just looses connection 
> and does not re-connect (maybe even blacklists somehow wrong). I have also found 

Reconnecting we can maybe fix.  Do you have logs?

> several related issues [1,2] and also there are related change logs for IWD in 
> several versions, up to 2.22 [3].

<snip>

> 3. Build IWD 2.22 from source (maybe using Debian sid source package?) -> how to 
> do best and will this work with libc6 version 2.36? Missing libreadline8t64?

I mean this is your only real solution.  There is no 'long term support' model 
for iwd.  You either run the latest or you're on your own.  It is highly 
unlikely that any of the developers will look at logs (or attempt to fix) 
anything but the latest version.

Regards,
-Denis
