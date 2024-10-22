Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4161C9EBA
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622664; cv=none; b=WxeF8+ytN2MOj0dO08xiek86cJIYZgNnYxbwCXbnvIOtFCP/JuTzsclEuvY+DT/RYvYnOoOi0oGPyEUcYpLRwcFTe9eNFsbC6zpGCXV0gJhHYEYCIU0NvyQY9vC7i3gpKyMxqJ/BoddtVwIVA2+Qo0bZmmHfxRtl8A3hOO8pBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622664; c=relaxed/simple;
	bh=sdWMWg8TQA5Ao8E/PkNFBw/A8KEqc9AV76y2oHDniXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1elzXqvHEhRh6eK9pOeZbbLxRhEa6THvJ922Dv3a+DA9kCgAUuPwJhVsf4WWuiSsZUhHGh8UFZYruhFGFHqx8lwP1xhljaUVXtpK8sagf5+PiN6C/sXrxM8iXjAuybffPGXgM9ZH3Et38hJFUXjGXQCuCa8kdvEjOQT47iNfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEo9NEl7; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEo9NEl7"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7180a5ba498so2698528a34.2
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729622662; x=1730227462; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/jaWpvjZ14a8TmrZZP+e+rxH9AhcWVZk3uTBzlZsgY=;
        b=JEo9NEl7tT9FKkTYWYTg5ik7X+JTU7BoMTAy/eSSbVLSdpICA99Nmbyu4yAxeouVMi
         4huK8Y8l0UkwIeVxCLO7LUBiJRWisgiXhOaq4amlrIsUrP8quK7G0mGVRpj0brfl4e4H
         vJrZk/dVMet9KwrdK0nwFhrnbcFt9rhGJKNX3xkvBViTOLj7uytg+iw315u8nmzgZ3Aj
         1LP4aGPreAhK9rcFQ6lCNAmQyDFUyTd/uxeJr2oqDUrjScM3/+an2lHWvd0RSMUM+tPf
         30xnYFWGOLNAdtbetnzfwKz+BqNmhTrpO28E+Gu3DHLtLqG3GkjcPek+2xtkM0UH/IFE
         1QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729622662; x=1730227462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/jaWpvjZ14a8TmrZZP+e+rxH9AhcWVZk3uTBzlZsgY=;
        b=YSvg9d7sOJYxksX3cyKFpzYU8L8W9aQggKcfi9k/9sedUfJgf9w1UweyMTrZXVUxMX
         a0oZA023BXr6XWaD/C/Ckbvc4CS+IBfa3lInD6spjAeCL0vWoT0bbFBCV6U8oSAiI3nv
         lr689GjrRnpKKP1MP+KHrMsmhL1B9+bQoTVRrazeb4ZxdJfmGzmdEjZbMK3rI6VVXtWp
         SCCAXJUgA4gUuJdBtOm35HqxhFjC6axNEe7S/CVjVOg1CWb76obV4iC1yJf1cCqy/GJH
         vOfN27UVZcxOv3LhgM1ZMB7pk0IgtHNLasaea3xOa7TqiWCtgvdyFMO5GzogTNhgE0wS
         Cqbw==
X-Gm-Message-State: AOJu0YzxCsctMn3kyIEr+9PcMggnLEoXzEUEfo8I4OK/RSOgl2Xw9J1X
	j7kZ8Jj0PLXLaK0TjHHCW9DgnK6VqlJkXwE/ZnO3OKnJqkgQaEAP
X-Google-Smtp-Source: AGHT+IFHvsvlDOZQkJ+8I+J3C2XtLfZQgFjR0ZGGw9keqzQeF9KdpiTLzmEjQ/JaidCzlLleMrPqbQ==
X-Received: by 2002:a05:6830:25c1:b0:70f:3720:16bb with SMTP id 46e09a7af769-7184b2bb6bcmr187789a34.19.1729622662255;
        Tue, 22 Oct 2024 11:44:22 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7182eb2210dsm1372592a34.6.2024.10.22.11.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:44:21 -0700 (PDT)
Message-ID: <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
Date: Tue, 22 Oct 2024 13:44:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, KeithG <ys3al35l@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
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
 <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James, Arend,

> errors out as its unsupported. I don't believe there is any way for IWD to check 
> if OWE is supported by the driver, and we just assume it is (Arend, maybe you 
> know of a way to check this?). It appears that what you need is a new IWD option 

Indeed, there's no explicit way of checking supported AKMs.  The NL80211 API 
isn't much help either:

/**
  * DOC: OWE DH IE handling offload
  *
  * By setting @NL80211_EXT_FEATURE_OWE_OFFLOAD flag, drivers can indicate
  * kernel/application space to avoid DH IE handling. When this flag is
  * advertised, the driver/device will take care of DH IE inclusion and
  * processing of peer DH IE to generate PMK.
  */

Perhaps for FullMAC, iwd should start checking for EXT_FEATURE_OWE_OFFLOAD 
presence, and if not present, do not use OWE.  Too bad no upstream driver 
actually sets this bit.  Unless... maybe OWE works with other FullMAC devices 
and we'd break things for those...?  Kernel folks really need to chime in here.

Regards,
-Denis
