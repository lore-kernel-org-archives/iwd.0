Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B42BE04B
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785648; cv=none; b=Ax5JxYfF+JQKPFPowb/MDj+ZD3BvUfvsASD6pA54glqpIkvCyz8MhvIzpsqjK8T4LGfZkXf/LkzKit5kvwyMuTj/pUV+823VuUzuae8Yi+PvZIX+3yXej5voGcRrzBvbLj/v2TaJWekU1fo5lxqikNqZ40n/aQeLBftQMa0AhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785648; c=relaxed/simple;
	bh=URMwsEyoTDSDxH2rN4vl4DJMpqcf14Kjs1AmM9LZDM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6XopatkAwLNf3GWEN7h/FPd4aZagI6Lg149TL+4a7oBMJ6bq4ZZtXWRmUbjyIKx6FbroobyFxI0RXckRSFid7BomoyiROS0sjm8gM4h5bk3avH8LEVgJzjtQHhOtlrE3Z/F5J12i+92GG6HCAzhliBHZnWPdptTvUUSbtLZxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQwkhGpY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQwkhGpY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a2ea96930cso16320825ad.2
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769785647; x=1770390447; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAN88uLQ/STGfk1zPNxcR+SPUoFVOw68Vfm9h9NIYqY=;
        b=dQwkhGpYpPt3X5hu4xH/U8sbABGpAHYf4l7IEM+QT9HyqbAMao3igXuYUJ7JfZK6kC
         jBNFEyrUgPXfoTcnXnmO0hvBPAXxME3QT5jeogbVagvwMWLfxYFL93Ck0vSTl2eHpTem
         EcMmyB3D9y22vjf5Njj7FaVDpOLuqE5nX34g/mqzST9s0fXc6HDpzXm/WyQVbyYmjqvl
         jGt+nMR0vteb2onnioPBKa/Tzrx5Rx6m9ll8BHTgFayFj2593kyQg+cVyNoyImFJzRdd
         X0BjVaYRjIpy9Gu2LYTcndgo0ZL9OpU9h1nec+pvfaufGBxj5K0tJrGvl1R3koq9lMYe
         vkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785647; x=1770390447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAN88uLQ/STGfk1zPNxcR+SPUoFVOw68Vfm9h9NIYqY=;
        b=dfwW7fGsHBmfXOAFFMJmN6YFlfxb4KMDd1GVVdDsgcqQTNMwivrFEmWRy5eJP28Tj8
         LBN6s4O163vR03a09Kzv10VkR3N5/leNCPPzEzo8+qxaGt4TI2aQYgDLQD08B8J6IOtF
         2/KE4cuw4Fn9Eda1tZwpkYAJiZ2FGJ2I9TK6zYqZbeuGoUETuAp/0PkfzU/Ldk6WTGEi
         D6tEQ+lMQlIOUr/CjqaHJksGbEpt3a8iOwn/t+D6zrAgHPXhwL/h5g+jpgTWrnZGk6X9
         mqPaTvLlDUORRWpLq07hqm1tvfCmSTuBkiGZTPlzyYMtXAVZmMGUnKoPmBoR55Zah5pF
         oOXQ==
X-Gm-Message-State: AOJu0Yxv5KuUJ4NOZvvBWiWKubXp4UOC6ZGsG/weYwGlKIgCQcQ71cmX
	hrJKuP4lVE/AU9oducH54/VSfIDmU76wM7ZGCHvLQTaQBMeG+lodyQ1M4XUueA==
X-Gm-Gg: AZuq6aKHi/TVNNk8jcIiDifCHI+DwBII/Wsri3Gf+DStxd2rf+qheledMnAgjyVuDVR
	CyTecmiQ8jE39ekNRYp6Txo81JWx4CLtY45uen4YdABrOZM2gu/1sRbiNpUu8ocZvzGCst8tNL5
	Ot2TfPVOjA0UG4QwB6A+ombnLMFxrDl6yzVzq4+sBhp8EqtCeoVEnBGkh/brY8/TBbvC+xCcK2c
	Vujcan75lxo+5/pEHb/w9JL/L2rw1iiXzMLYZRbXpKsdqRfYjfLcuBi8yPRWF1Y3gfIo1NcOZtY
	Rua6wxSXksN0+LnvF1xj2QfkqDwWjw/3RvMF7Ngy//vbjIhsjHMLh/sE8bz5YXWO7xyISuNjvBS
	+PYqfyBkFbK4OPNFj0MSqKxUPRJwnwdAzezZ1Mj30zkHlQEpNMJvx2oBKNsaIbLvV8ankNJlTLa
	NWQ5INT9dcujQtAUGLt+ZQLA==
X-Received: by 2002:a17:902:f60d:b0:2a7:682b:5098 with SMTP id d9443c01a7336-2a8d959b11emr28998285ad.9.1769785646839;
        Fri, 30 Jan 2026 07:07:26 -0800 (PST)
Received: from [10.201.20.209] ([71.181.84.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8b47f4717sm63745665ad.18.2026.01.30.07.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:07:26 -0800 (PST)
Message-ID: <4ab7e9b9-be27-402b-834c-3e71bd58a476@gmail.com>
Date: Fri, 30 Jan 2026 07:07:23 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there a way to manually force the security protocol with IWD?
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: iwd@lists.linux.dev
References: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
 <3d09fed3-9728-43e4-840d-13052b5fbf6e@gmail.com>
 <CADXxVS+_B2r0yAUKKD5X_xJ6GmfkfkngwW_XHQyti=+9cMmzqg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVS+_B2r0yAUKKD5X_xJ6GmfkfkngwW_XHQyti=+9cMmzqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/30/26 7:01 AM, Bryce Johnson wrote:
> Hi James
>
> On Fri, Jan 30, 2026 at 7:48 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Bryce,
>>
>> On 1/30/26 6:43 AM, Bryce Johnson wrote:
>>> Hi All
>>> We are working to get our product through wifi certification.  Our
>>> testing company mentioned there was several negative test cases that
>>> were failing where IWD was connecting anyways because it would decide
>>> on the security type based on the AP.  Is there a way to force IWD to
>>> use a security type that is different than the AP so it would fail the
>>> connection?  Can we disable WPA1-only connection or force WPA2 only
>>> connection?
>> There unfortunately isn't at the moment. We do have a "developer mode"
>> by specifying "-E" to IWD and this seems like it would fall into that
>> category, support would need to be added of course.
>>
>> But I'm somewhat confused (and maybe this is just poor test cases by
>> WFA?), why would you need to certify that IWD fails when using a
>> different security type than the AP? A client should not ever use a
>> security type the AP doesn't advertise support for... This feels like
>> its testing the AP, not IWD :)
>>
> I'm was requesting what test case fails and if I could get a copy of
> it.  The only thing I can think of is that they want to disable WPA1
> for example and show that the device won't connect to a WPA1 only AP.
> Or maybe for a product you only want to connect WPA3 and fail and not
> connect or not allow the AP to downgrade the connection.
Yeah I'd be interested in the test case.
>
> Maybe it would make sense to allow a blacklist of protocols you won't
> allow IWD to use?  For our product we wouldn't allow open or WEP
> connections for example (but we perform that check outside of IWD).

IWD already won't connect to a WEP network, so we're ok there. You may 
be able to coax out some behavior with the following options:

main.conf

[General].ManagementFrameProtection

network profile:

[Settings].TransitionDisable

[Settings].DisabledTransitionModes

Anyways, lets hope you can get the test case. Shouldn't be too hard to 
add some support for specific test/dev type requirements.

Thanks,

James

>
>>> Thanks
>>> Bryce
>>>
