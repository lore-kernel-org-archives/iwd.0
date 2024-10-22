Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1C1C9B9F
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624241; cv=none; b=d3VVJoXwvxfWwOQinxFx97dxP9Eck+gU+P2K5/pevGpt6DJXc7YlN3JT+bFwX+3RONtmyD0IE48k10Zn13NoLV9PAmmKaXQTkjXwPsscYk0FLPXFqugXQO/PJ1SsKQVQ2bgepLi9cTiW/2SLeaRvanGvXx9F4eqGcg/2vE7hN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624241; c=relaxed/simple;
	bh=jfxg3axgYZ1RZp27S908dxO8oFzhBt/22emnmYjkj/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbRdHv4m3w4RUpLyEkya2qj2oReJ41c9QU3lhE8N/fNCLX49zdJMhpjAuexaoKeLq0XjTO7Qb2N/y/PMYMCTSvRwP4VXoNszUDyttEDJj19wajzCWLORu9VsUCV6h+KIyQvn99Qd+EanGCapwfmBadSba10ILhR61KS+uRC73+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyXn9cAH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyXn9cAH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so59077425e9.1
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729624238; x=1730229038; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNdurwGgZbrPXSXzm/CFi8d3lZoN62ZBBP1a3juSzfM=;
        b=jyXn9cAHYMXf3jd32VAme2++h8uX3BWotgezx+rt+PW1+eh+LGVxR6Ucz3VUE2rfPv
         xFrhMzKTD/7rbd/wnhKBw/adfxLvQyW3+/RunMDfWIu/MX9tPq/c4/1xUgqqbKS3vWhA
         dsNJbeXp0SBdl3G+azhdU9tpVAPRpwluZQ8PnyeVcVAc5kfcI0mTzlW7Ul2ysEhoBkEG
         CJN68nocz6SZV3HSktDnpYFQSrtDAZ26/wWy7oNj7EVvR6+kaFzPJcyaiNkjhGpzf1eo
         OatMjf7xZxecAbghTrZHJnoflMOV49FvHGClhm8343j7O54L14gAhoU49A+I4JLGjsWK
         Y1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624238; x=1730229038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNdurwGgZbrPXSXzm/CFi8d3lZoN62ZBBP1a3juSzfM=;
        b=ZlwNo3hpRcMydQe3nUAUm3v2Jz5qj5xSWXzYcCD6pWPkvs+kvxU05/sXvHwj+zxXwD
         e9tZiNEdpqOq1kAy4P1d+BBr5AifdVXI4uVVMxTSU/F/C89rCJ0Osi7zzFo5lRzTOEsW
         RxxOh/RKFoE7OtdBi63OOh0j9lBF2DkT0lIofEAi9xYziCz+gk+M+c6ubh1yYKEFQUA9
         PfGhNYft13GXUPyW9O7mEK7HyfSk00bCyMtkDhyoptxNGbacuw1o59nqDp0EMy+KEpcd
         UyogyNOLMaun4CEM4RloqIHsowzJRQTtZhUth4jvV7B8j3PkRq87bOWUkFbXCW9gA/iR
         497g==
X-Gm-Message-State: AOJu0YxT1ZINqN9X0/0gkEGD7oZOrJEjBK3jbNiM5mIuQRwURavJdQzm
	/ULEeqlG+BgXsiHT0Ee6St7Br+tG7MXIQ0LEw38ujI5bS9emF/Kx2TuCVmPq
X-Google-Smtp-Source: AGHT+IEheHg0s5sHB3acbPeUlpdhQ7M0++lZtObFbhyGCCqNynkf0/Cgy5nZtYyDg5YC6UJfZH6KdA==
X-Received: by 2002:a05:600c:4f0c:b0:42c:b7f9:4bbd with SMTP id 5b1f17b1804b1-431841890b1mr2055115e9.26.1729624237506;
        Tue, 22 Oct 2024 12:10:37 -0700 (PDT)
Received: from [10.168.3.25] ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570ffcsm97434325e9.2.2024.10.22.12.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 12:10:36 -0700 (PDT)
Message-ID: <8ec3b3f7-9489-429a-aaca-291f87291757@gmail.com>
Date: Tue, 22 Oct 2024 12:10:34 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>,
 Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, KeithG <ys3al35l@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
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
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
 <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
 <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
 <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
 <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
 <d5d5357b-cc90-47fc-b7bb-7f25d99972fc@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d5d5357b-cc90-47fc-b7bb-7f25d99972fc@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/22/24 11:47 AM, Martin Petzold wrote:
> Hi Denis,
>
> Am 22.10.24 um 20:44 schrieb Denis Kenzior:
>> Hi James, Arend,
>>
>>> errors out as its unsupported. I don't believe there is any way for 
>>> IWD to check if OWE is supported by the driver, and we just assume 
>>> it is (Arend, maybe you know of a way to check this?). It appears 
>>> that what you need is a new IWD option 
>>
>> Indeed, there's no explicit way of checking supported AKMs.  The 
>> NL80211 API isn't much help either:
>>
>> /**
>>  * DOC: OWE DH IE handling offload
>>  *
>>  * By setting @NL80211_EXT_FEATURE_OWE_OFFLOAD flag, drivers can 
>> indicate
>>  * kernel/application space to avoid DH IE handling. When this flag is
>>  * advertised, the driver/device will take care of DH IE inclusion and
>>  * processing of peer DH IE to generate PMK.
>>  */
>>
>> Perhaps for FullMAC, iwd should start checking for 
>> EXT_FEATURE_OWE_OFFLOAD presence, and if not present, do not use 
>> OWE.  Too bad no upstream driver actually sets this bit. Unless... 
>> maybe OWE works with other FullMAC devices and we'd break things for 
>> those...?  Kernel folks really need to chime in here.
> If you provide a patch for kernel driver or IWD, I can test tomorrow.

There are two RFC patches on the list, which I haven't tested but 
hopefully that'll do what you need. You will need to add this to main.conf:

[DriverQuirks]
OweDisable=brcmfmac

