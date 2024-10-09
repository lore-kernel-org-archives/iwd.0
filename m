Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731A2CA5
	for <iwd@lists.linux.dev>; Wed,  9 Oct 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492640; cv=none; b=KUPAmRHx7ycRTtM9uh4KbbKj/CDoL9RA+PFFKqD1NzQ+7QtSLsynzWRF/vF5cDepJG0tTIkaKyLJjnB7TqgIPd42SKq1/MlEAeDb9ESeYofPqGe1IFHpz3SNEkBBD00dk0Rsn3Kz5IZB2f46okmr7pF/i8TUSvegWgUQMbMxzoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492640; c=relaxed/simple;
	bh=va7DkGJ4yneWUD08Kra+f22ePqwO6A4CBwaVUKI4fIw=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Lu0qaX0IcBYNhdn9ZkTbek5iq17NQPzfEt8zFFfZMod2NiezK0EIIz4KSGZYuROlnNYqa3dxSw3TgCcDdL5ChfQh2OioArnGaldvwMjC3XI3CVTV6dMnTm0J4UKPKahN1vxPITqiYRHb6e8pa5EHqjDTV9wbXrVqMJlr+Uak2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YMdco5Z9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YMdco5Z9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45f07eb6f03so654151cf.0
        for <iwd@lists.linux.dev>; Wed, 09 Oct 2024 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728492638; x=1729097438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ubzy/23PtTjKMI6iCXOzGs97f0jOAMVWihIZMEAl3wg=;
        b=YMdco5Z9bNGSmXJK0NUUHpvWOZljFG0eHDg+IXst4Jr8Wyd4Ygpm6vsCivYPRWVn+E
         YXa2OahNnZNhmtZPTYIwT/1gi/IHayRKR0xM9yaRknbQeky851+cJ/7l1XIRkq3ofXDV
         kBTZVeCNc++z8whzYPHefPat9/vRek4XKgoA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492638; x=1729097438;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ubzy/23PtTjKMI6iCXOzGs97f0jOAMVWihIZMEAl3wg=;
        b=CMQ09Io9DaqMi/WmbNCFuMWzD7dyqtym9fhUS6qOnnBPZAXFjY0ldD+2xO+HNWLmi6
         2IhSod7fblS40bOIBHnQIdZ2nH3NlwriXrV0sx01SF1G8+BwpJnwYHi1T/fySe6V6Iy8
         TVpjhsWS/5xrNhWF2ju37QQBijvcQo5dVg51eRh2vvCIgn8HK7c4Edpbmm+UjmuKpvKq
         Z+xWMMBniRJf35WjyZ63wb3H4wM+xxF8lrYOeskopRHO5eGLRcHfvTnja5VIAyLiyjhH
         t//MHlAL+zygncjwYIDMYrSmXo6UIKlQFdYxFvKl8zrvmHn4AcV3IkzE80LG1y3cwvzt
         QcSg==
X-Forwarded-Encrypted: i=1; AJvYcCVFavzszeS2TElFIQx9cnnujSxK2Za90u+m2QA/EvfENlnApyo8SofFx5qJ/pJMyqZk9fo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyLkWi/MoI6bD4TioeRPG8UuAeeKsByxAl28Gs0x6le4HouZ3+0
	Os+QUsxwT+n5riaGuV/NCH/Glw8wQaiZnK/Tw3DwG92Szz4h0SJhMgD5DzQd3Q==
X-Google-Smtp-Source: AGHT+IHR4CcSGpD+GTwwb2iW/tahq2vHc5pp2iTK0KbMsogNj35cv8G4qMKnfQ09EZtUU/qywhVkYA==
X-Received: by 2002:ac8:5748:0:b0:460:3a55:efd4 with SMTP id d75a77b69052e-4603a55f3femr28957751cf.59.1728492638067;
        Wed, 09 Oct 2024 09:50:38 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74b20c8sm48287881cf.9.2024.10.09.09.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:50:37 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Denis Kenzior <denkenz@gmail.com>, Martin Petzold <martin.petzold@tavla.de>, <iwd@lists.linux.dev>
Date: Wed, 09 Oct 2024 18:50:34 +0200
Message-ID: <19272307f90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
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

On October 9, 2024 6:07:16 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Martin,
>
> On 10/9/24 4:43 AM, Martin Petzold wrote:
>> Hi
>>
>> PROBLEM
>>
>> We (still) have some trouble with IWD together with brcmfmac. We updated
>> firmware for the chip (Infineon CYW43353) to latest version 11.171.0.24 and 
>> also
>
> Ugh :)  That stuff is known to be problematic.  You might want to involve Arend
> in this discussion.

Is this specifically related to WPA3 or in general? The version does not 
tell me much and I don't have access to Infineon firmware to examine. I do 
know there are two variants floating around regarding WPA3-SAE support: 1) 
supplicant in firmware and 2) using EXT_AUTH. The latter is supported in  
downstream repo on github, but it has not been done in upstream 
linux-wireless. I did post patches for testing last month.

Regards,
Arend


