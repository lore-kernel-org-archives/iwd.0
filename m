Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A51BD03F
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621492; cv=none; b=TL54MS22u3WEjtdYJE5b7JDbAlcigFbSnkm1YGv2RyxxbVeHu9GImR0qo2gZXbteFidBe9tmrozi6AkX3spDOMAsL9dbGamwZaQZnJhJBwpuF07QT/ttZeA2Fbust9rQ21AJ9GZ20QovZOFHLy/6K1lwOgY20WbgHfYmZsRHWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621492; c=relaxed/simple;
	bh=neGShzyiKVmxwjSqlKD1bgschBd4ynxU5F/ydEuf/5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnujGxxkad62PERLqY/ky8sk9zIYhpSreyil4vLgpjwfLsplLAFImJQ26ANm7nGGQStDHCX1Kp0QauJeZ2dwzTzZVnHh+k6I+MPmWL/LeONS0tEPu9+za8nI9dYbwC43vgsR/O9PYTfRZl5DXO6smZyxd2B9Iep/owIy1Acq91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aggz2FLt; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aggz2FLt"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71811707775so2893090a34.3
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621489; x=1730226289; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tc1CT0lJHbhvV3zmYAW/WwCw0aa2Aiq+b3lGeXGInB8=;
        b=aggz2FLtYcUWCZ1p15dqt7nILK27ephiiI/qpfPNZExHUUCPfIZM1zG6uWySrR4eaz
         /QBp053yEv/u/2R6Sx7Z5I6u5THVaVac4hIdwL60z1mU+8w0CuhPejfbGZYXxBByRGhv
         v+72lpRDOH6TOeQbxlA6Ell2PeNzz7pbdKyDyZJ45Qk1FDWM3kK3ABKZ9rAZShFd674g
         xtpJavYFnYCm2N3Mfgd4BSb2srMxMPV6BUp2eQ9LNsfNuiHVwl1jCQfV6sSXMGPD9Pg4
         l9yFF+nJwXp7XSVO1df7mRTMpCoQ4HW54rcKwlQeLcVdO4Xtv1EGIB8ckZny+lfFO4la
         oG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621489; x=1730226289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tc1CT0lJHbhvV3zmYAW/WwCw0aa2Aiq+b3lGeXGInB8=;
        b=YepXUYm1Tv51DD7WWwOj9V5oLgLJ1KWO+zB0bzi0RGjeS1N8/rMIstLapUaWSO1nqm
         73BjUm+Pp3TL4vSG/0p48JOSFJ6ayn9rN5R6RnS9UDKx1j9gfglY2ohgEX3fbjGSED13
         rdeq2X3jgCZe+YOAltHT6yaHLPUw+bXUglQ/ZQlBFnvm9zrDKFAy5KojHudDCBTzubbC
         vzQ64oWNsgWx9DSUOGOnqKFFKnfm1KrPCAO1BDdeTrWpNFVGaKNUa2Ozr7mhjgH/surg
         c5q8l8nsdq8DslG599OJjxIE+NewvIuu2zpa3L7RWPXFIpmTxd9/EszMMvOy1TTrxgOr
         ZCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUbJ9394gHy3RSFcE43KMFvoE+mxFqfPhWZcQtALntE8bsU93mQp2t8ZCbTaT4fBZzrEhs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwRpn9dFq2TaIE/FCDOyORQTJ9xuxm2+VkUi2v137MfO0CoGPbG
	eKmcgq/3GTPkDhRlIi6cBvEvDTdrWAVaAJ9bQNLk2AQtBJ6B6r7b
X-Google-Smtp-Source: AGHT+IFno8I3iYyi1meeo98V+v8vht6oUCWag01zuxeKEGK0boQEAPnGrERlDnDL/1nt3KYNk4DGpw==
X-Received: by 2002:a05:6830:6995:b0:710:f3cb:5b9d with SMTP id 46e09a7af769-7184b42bc5bmr148750a34.24.1729621489567;
        Tue, 22 Oct 2024 11:24:49 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e274bsm31261466d6.118.2024.10.22.11.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:24:49 -0700 (PDT)
Message-ID: <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
Date: Tue, 22 Oct 2024 11:24:46 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Martin Petzold <martin.petzold@tavla.de>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev,
 KeithG <ys3al35l@gmail.com>, Arend van Spriel <arend.vanspriel@broadcom.com>
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
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
 <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
 <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 10/22/24 11:04 AM, Martin Petzold wrote:
> Hi James,
>
> Am 22.10.24 um 19:40 schrieb James Prestwood:
>> Hi Martin,
>>
>> On 10/21/24 3:10 PM, Martin Petzold wrote:
>>> Hi Arend,
>>>
>>> Am 22.10.24 um 00:01 schrieb KeithG:
>>>> Arend,
>>>>
>>>> If there is a patch for brcmfmac to use CMD_EXTERNAL_AUTH, I am
>>>> interested in testing. The last time we tried, it errored out and did
>>>> not work as expected.
>>>
>>> Support with our current chip for WPA3 and also OWE by offloading 
>>> SAE etc. to IWD. That is possible?! This would be great!
>>
>> Have you also checked with the vendor (Solid Run?) if SAE/OWE are 
>> supported by the hardware/kernel they ship with (even with 
>> wpa_supplicant)?
>
> Vendor is Variscite and the chip is Laird LWB5 (BCM4339). According to 
> Laird WPA3 is NOT supported. However, this is not the problem: I knew 
> this all the time.
>
> The Cisco enterprise network is (should be) configured as WPA3 OWE 
> with Transition Mode (there should be one hidden and one visible 
> network) [1]. And, my device connects ONCE initially (it is connected 
> and online). Then it looses the connection (I assume maybe due to 
> roaming) and does not connect again. Also manual re-connection 
> attempts using iwctl fail (see log). All auto-connects fail. Maybe you 
> can check the logs again, and can confirm WPA3 OWE with Transition 
> Mode is configured?

 From your logs I see no successful connection, but it looks like the 
OWE transition mode is configured on the APs. Based on what brcmfmac is 
saying the issue appears to be that IWD chooses the OWE AKM when 
connecting and brcmfmac errors out as its unsupported. I don't believe 
there is any way for IWD to check if OWE is supported by the driver, and 
we just assume it is (Arend, maybe you know of a way to check this?). It 
appears that what you need is a new IWD option to force connecting to an 
open network, not the OWE transition/hidden network, right?

>
> [1] 
> https://www.cisco.com/c/de_de/support/docs/wireless/catalyst-9800-series-wireless-controllers/217737-configure-enhanced-open-ssid-with-transi.html
