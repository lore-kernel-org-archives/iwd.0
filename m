Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903F1A0BF1
	for <iwd@lists.linux.dev>; Wed,  7 May 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635486; cv=none; b=SUfuvpE18T9BpTDFGRZ8p1+RdlFQfKtlXoUQgZsCN648CoHnSU0CCv3WUfnxctFIT1jpi62P1GnSCwxIRc5BAd0MBeX6Cm9Cz0/rvOBlGlGM/g+Fi6YRDQZUQnGdEHm6d1zHRqh6gl/G4wS/3w/pfPSYkKNWItbQayTQ7zW4R6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635486; c=relaxed/simple;
	bh=YnVaMNn7XM5q3rbhhyg4uh7tRk8cRjGAKIjy2RgAo9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BFoaLbOpd9BozszDwy6bavSCgwF6G8lgSUb/d6e7ISz8/Ox/Ywc0yjT0G0ymPWrk9Oj1ICsg9kt+JL261OBeQbviBjfLLhOMAz57PDDOd6sBWOV4Vpyp9ogPMY68ix50zKXQdiISI8r+B4ZZkkUlrxJ8ATnu7171Y5zqmerxLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4nxB/zv; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4nxB/zv"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c14235af3so4460769a34.3
        for <iwd@lists.linux.dev>; Wed, 07 May 2025 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746635484; x=1747240284; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hUJe3S+R93rfy7FAPPBJ2imz5wW3HPPamcInOjbdaEc=;
        b=g4nxB/zvZM4PwbZZHasSGJLg0rOsKXMiws6bnw0bbiym1SqD/fQBUXyO1empdYltot
         0Wh62iqA6gsJDQCliEQy4lcu9ZW/g88wbpBM1IypaDlpulh4pHO/1kXayeFk+ebDSWDS
         Z5AzpyR+HvlJgT62+OabVflSfkqihtdqEhA14VmhqEjXFBRIN9H1rNoa7Cb/ScCb8L+/
         Nj5ziHOx+vssf4ZAxUsX8hvqDV4WHVYxaKQAu8mvyhDvk2B76ag2uPyfH+h4KVkoKMMS
         VCkbTx+hg8ZPCfbJ0dVDUesx6YyG3G981VCaI5lDtsa22ak4/3sejtD6jQVY5Acv120i
         Hj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746635484; x=1747240284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUJe3S+R93rfy7FAPPBJ2imz5wW3HPPamcInOjbdaEc=;
        b=Mn3rTbZLqn8yARoERFsElzmxXFHazwKrp03F5662GftTFgRTZ2UJBIVjFUaxiJxkLW
         sBf/v3xWAxLbGWMUhtnLVSKqO0m3ZWwF3W3//05lgvIwm6Gu2Avs4mJgv0lPxLKGcvKm
         i6xEROD1YQCCqEGwM0idmwHiNudz2gRVnCl+f7o9F25nvRMqmePn0RMIyum2CeEpIuLZ
         ++vWg6tUKeSGBdjFISaxiJfIFPB1HtHtJVgJ0NzTz8XpoQhkrpe3rCVfgYtDvx6YH7mm
         BYP8Di1lq1e9bVvGrrq1MqBtiA1i8F9zmrcUStcf6ETWEOT0qE57k6v5n3RCt2ZE1tpF
         A4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWniDSTDVMHfcV4UbMYVjucOEpctIhzu6JRIHTZlp7ZH8/bvdop64679ewSWXBBo+aXsQw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+V0cuykTERogEvd4NQlTl12H4kpIoQYjG7Lw3skn2KiENUmeI
	0HI6952Cy023g7dJan5+lYloXrqgbtiJIEJan7H2Q3eEFcPSs5I/
X-Gm-Gg: ASbGncty1xyaLHa44hL3T9ZDqok5AAenChJcvx31wTCkX0XsKM8GKnLfMS2g9qLTXgd
	d+0/qRMA0PXumWZuMWgRhGqliCBlsY05bqI+wKq6xl8MPfDRRHZt8Lne4/mdDrWKAylichQRBuH
	W1m4msYSedjC+c37fYAnhFerrHxVM0RTDRgB5IjYOCqkUT2P4Hipu4ZZE30RYUXxmMfczduzhR7
	FHnfjv5ZFuofSQLdNi60n2QsmkWPRHmVqeHkBqJLMIgv9h2U4QUqXTDAy3/5+qTHM9jwKEjcSC9
	rESLV7P/k64vRENEL6G/RgPGYz5fNQH+0ixRSdnnLAK07NUio94fLCc/nrAJO/g8FgC16Cx2xd8
	b275smQ==
X-Google-Smtp-Source: AGHT+IGuVFnBYaitSP+7/u0s/aKzVBDR1PfsKEfGF7J0Tt/jYi8XHvu6EWQgM2AoExHLs5yZpF0N+w==
X-Received: by 2002:a05:6830:6c0d:b0:72b:8326:f0c7 with SMTP id 46e09a7af769-73210b194f6mr2820783a34.28.1746635483738;
        Wed, 07 May 2025 09:31:23 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-732109fc94dsm612290a34.19.2025.05.07.09.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 09:31:23 -0700 (PDT)
Message-ID: <d89b7056-860c-4da1-a6bd-4eac4fd9b0d3@gmail.com>
Date: Wed, 7 May 2025 11:31:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] station: improve roam scan strategy
To: Alexander Ganslandt <alexander.ganslandt@axis.com>, iwd@lists.linux.dev
References: <20250415-roam-scan-improvements-v1-0-12827e086895@axis.com>
 <20250415-roam-scan-improvements-v1-3-12827e086895@axis.com>
 <ab31a956-b65b-4b42-b37c-a1c63385d3c9@gmail.com>
 <c56180f6-8eff-479e-93ab-522bd8a43ad2@axis.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c56180f6-8eff-479e-93ab-522bd8a43ad2@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,

 >
> Yes, it will start reusing frequencies and might never reach the less common 
> frequencies depending on how long time the scans take. That's definitely not 
> ideal. Looking at the age as you suggest has the problem that it will eventually 
> spend time scanning uncommon frequencies when that time would have been better 
> spent scanning common frequencies that are getting old.

DFS frequencies are valid and it is quite common for APs to operate on them. 
Not scanning them or delaying the DFS scan excessively can lead to really 
terrible user experience.  In fact, we're having this problem on some older 
FullMAC hardware.  The firmware doesn't initially scan DFS frequencies, even 
though it is being told to.  This has led to all sorts of fun issues and lots of 
$/time wasted.

The less 'preferred' frequencies can be scanned last, but I think we still need 
to scan every valid frequency before starting the next roaming attempt.

> 
> Maybe this is an impossible task to solve perfectly as there will always be a 
> trade-off, maybe it's better left as configs for the user? In my livestream use 

A typical user cannot be expected to optimize something like this.  Our 
principle is to not rely on the user for any configuration.  The default 
behavior should be good enough for typical uses.

> case the APs should be configured such that most good frequencies are in 
> "neighbor" or "known", so I would like to spend most time on these frequencies. 
> However, for a use case where the network setup is unknown, having more 
> exploration of uncommon frequencies might be better.
> 

+1

> We could have configs instead where users can define the subsets and age 
> threshold. If they don't set anything, the default is the current behavior. If 

No.  You should not be relying on the user for anything like this.

> they set subsets, the roaming algorithm will pick frequencies from those in the 
> prioritized order, just like this patch does. It could still get stuck scanning 
> the same frequencies if the age threshold is too low, but then it would be a 
> user configuration error. We then also get rid of hard-coding frequencies in IWD 

Strong no.  It is not the user's problem and never should be.  Also, I really 
question using 'age' in seconds.  I strongly suspect it is something that will 
likely fail in all kinds of unexpected ways.  Hardware has all sorts of strange 
behaviors outside of iwd's control.  Scan times vary wildly.  A more stable 
solution is needed.

> and all problems that causes, but still give users the possibility to do so if 
> needed. Does this make more sense?
> 
> On 4/16/25 19:19, Denis Kenzior wrote:
>> Have you considered maintaining a scan_freq_set of all the frequencies scanned
>> by the neighbor and known-frequency stages instead of maintaining an hashtable
>> based on age?
> 
> I don't completely follow what you mean here. The reason for having the 
> hashtable is to know how long ago a certain frequency was scanned in order to 
> not scan it again too soon. So that info will have to be stored somehow, or did 
> you have some other approach in mind?

See my comment above about using a time based age value.  I would push more 
towards a solution that scans every (enabled) frequency in some sort of 
preference order.  My opinion is that using a set of previously scanned 
frequencies, rather than a hashtable, would fit better into that sort of strategy.

Regards,
-Denis
