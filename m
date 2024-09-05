Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E331A89
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506620; cv=none; b=OGLR0emw3TW/hnBTG+YL1PdMIuD8aTPrDZ5ymnzfx+n30+zPI6sDCI5IDGSJ4l7uhKb2/ZS1F7d/4BzzUHrxLdnJ9sIPL7vCA0pABF9dBnj0RnaYdVeLPyGU/GZo7qG34J8sCwqSjmUvWpZ2WsBWvx7IMKNb4VEq0uPL0oF1G0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506620; c=relaxed/simple;
	bh=7df4fO5hT33k8DwSIgS63WV+5ncfoXgl6yn1Oai948A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvFfeb3o+feL5L1fpMiAtKJsjyLZkGF1XxFlr9Fjd23IswrYedTZGyQbIr1Oo5mY3rzcPfEwnIF+pj8PHSejtTbJG83eb0+vRmatukbgrjwdiA3fDLtE/zhEnTH1EOAj/u14wdsM26JCmYlGhTEabWbVieSyjY3W73kHAldjnWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa5u0S98; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa5u0S98"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710ac7041c8so251765a34.1
        for <iwd@lists.linux.dev>; Wed, 04 Sep 2024 20:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725506618; x=1726111418; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhVYOJ+Jr/h2te05dG/C6hDr9vFlw877Cy1R96sS7ZY=;
        b=Wa5u0S981pv6b2l1O+OaSvh3kzI4HIaGB9eUfgeQZ/Vrel8DkluICm3Si99sfmTawH
         GHCnY9Ft18zVqt3/xRsx3GRsr/l48o3r2EiIuFUYFXJZjoJhUru8Eh2bOiIzBbTPRVmf
         V8P1c0PmTjKinKL1lgVK9AOX6ghFfds3JDdGvK6ZX9cBOStamSmfIfCviBLExqpRYdnu
         BXhwP08pLkPraa7bgAXEQKqzbQTV7zNJ8/pBs7FLU/SoOnHlhmkZotIFfFweO1hk8ZgL
         AamHL6bmvu4gqkVSojz9JNWux4XXKzLXhJDfV1dakREgSv5IKaiu2yNOWWX2UXgz5apR
         Du/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506618; x=1726111418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhVYOJ+Jr/h2te05dG/C6hDr9vFlw877Cy1R96sS7ZY=;
        b=Zst5I5g42+Qpl2CC4sDmJ3gw3HqzqHcGFUFOvlVlsv1ORWqWdm6J1s6o5A51T0Icxi
         pNmgu2atbzA0TMP9+Y1ONCXCIKVZZcRQQZLK0ZQvKe+tDiIIEN7IYFrumAWQh23xtzQ6
         cM4KnlKdZSEdLCDD5rRC9qU7cEGl5PFO3ZxsFLDHhzOuEXAzvpiOTNagWuJ0R98fWutz
         q/n5vbkGSmepGEt57Mjaml3auuc67AzhLfxJxTwhoPoUo0valLEbNm6Vw2/kWPWgCXcI
         TTCfVpGKgU6InweT/GSdZLXlHDtuRo5++o2e7EbRacJ8bkbK+QL0qABUr5XDF737bru9
         /T9A==
X-Gm-Message-State: AOJu0YxyojEAEWn4PgMs57GKCUxzaLPb2M05YbJ9d39vrHO9Ce9Ors4n
	b0IB2qWchKEihGU9s9ZZrQAjTZAIgQ1MSUBYa+B3uaSWXAANQysZXSqjLw==
X-Google-Smtp-Source: AGHT+IEvH5uMO4qtk3pS+JTFXV0TU3XDhF6hNukll5VPD3Ol13LQ9QrjYNFq1d8sypf4KXGdBPINyw==
X-Received: by 2002:a05:6830:4188:b0:709:3792:5e0a with SMTP id 46e09a7af769-70f7105201bmr19609171a34.17.1725506617933;
        Wed, 04 Sep 2024 20:23:37 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70f671aa882sm3088413a34.58.2024.09.04.20.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 20:23:37 -0700 (PDT)
Message-ID: <7b6f85d6-136f-4b4e-9b67-f71879191cd1@gmail.com>
Date: Wed, 4 Sep 2024 22:23:36 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: James Prestwood <prestwoj@gmail.com>, Daniel Bond <danielbondno@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
 <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4083bf62-20d2-46e6-bfae-c926c2acbfe9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>
>> The issue seems to be resolved by checking that results->sr is set:
>>
>> - if (!results->sr->canceled)
>> + if (results->sr && !results->sr->canceled)
> The patch on the arch issue report looks good to me. Can we go ahead and just 
> send that patch with git send-email?

Why is results->sr NULL?

Is it caused by the cancellation path introduced by:
64d68b4f080c ("scan: fix invalid read when canceling an ongoing scan")
?

Or is this caused by calling scan_get_results with a NULL sr like in 
scan_notify()?  If sr is NULL, perhaps we shouldn't be invoking the survey path 
in the first place?

Regards,
-Denis
