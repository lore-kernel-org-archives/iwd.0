Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113091E0087
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461366; cv=none; b=maZhrLPNA23l3J4HBK8quEiD/MuN7igoPPM6dDDg7oJ8NiQQV1RRS5Qng0lu21dFSC3eGluaj9agLoZ8iP2xbR+0FLgJKzS7cvmbzzbNUBKjEV6zxGtMcm4deO+SxxGQLsoghjUO1S8a0VQBOclvS4Ao877QdzR1bH30IuRIysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461366; c=relaxed/simple;
	bh=Ai5+If3LqqWIIdZXpZqvoX/B8xhbJibwMnXYug1sBHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DJsHhVAE+trdMI9QxsHi9GA5w4GV3CjS73nE3kEq+UwOtn007lzFgW4N5kZU+UC2jw+LQpPjKBrdHRI4HEAcOy/mGb4eTvM6D6WYd8ZcUAH50jzmB2KT0qneyPE0NfMd5He/CvrC36N9SqnPtVHow6aMVlcmxWk+IbFRUFQ6gtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmeSPfzI; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmeSPfzI"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e44fda56e3so9303696d6.1
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739461364; x=1740066164; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5SQgXdP1ca3iVIDLzprBEjX7rRbyMg/gAG2rtjy9IE=;
        b=DmeSPfzIbXjplSCCbP+oLRZSjO3pQhoQS2wGSEIjETGNmHc2NWJh6Iu5uHFwLRQIcn
         uMEG/0N8wIdwTuyZ6SEc66/OG52Ec5PMEHqU7JEHnVslNkcZo+a+C3H9WuHcDgkw6UgH
         2alSNEi06NXYev7Y4toPF3DsCQ2TMmIMVT5RLVSa615F4VoP9UioKB0zVruhyY+CJBG/
         BBw3A0+4onk8Q+vufWK8rgV7Y9tFocf0YZVl3m4LdQw1oqNMIuMRadcZR2LR2b4Fh8Rp
         GRk2b+u9TSUDK9lRBcwh1YUPwNuZuSpymqrfVx7QkK6Ku88s3eYeL9KQKNP3jqGLsC5u
         RpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461364; x=1740066164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5SQgXdP1ca3iVIDLzprBEjX7rRbyMg/gAG2rtjy9IE=;
        b=DLNBt+JjmDVt1nUtIrZkAH7w3q6bNkGdVH6jfJqrcT7jb94t7LOuncnjZPtdEi+lrD
         E1mDfaqUdfWhqXlR8lD5H6AnOKRLwFwOmMgBwF/lormGYsDsGVZ9ZnJlqz7AAhdJ2u+X
         gtEnbe7O6znMkHEXzVhSN+RljX3F9riWT469RpZxv7d/hEaJD9JtiLLHSpghl2xbhLLX
         2zKOnO5esk14WWbuMEoSjw1ASbNvqzAFbM8FVvW/GDrfSWA10iz8q5mRAgmOE3ic58Ka
         cqFfTq7ezwe2Q1tgl1s3JnEefMAI0aSgNZGp9pO2xpRQyucZtN1WNqILzscxhZT+MWPL
         pchA==
X-Forwarded-Encrypted: i=1; AJvYcCVhE9iDa4zUphWd6MHah7JeLDhN4gLkxcV7h7y4xl0K0Fx7VSEBjexVA1k6V2hielnmnHo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUdUBsm6+lK7/1Hlao+HY9aed1/GSkt9vcOpGq9MC1bA79JlEv
	8tSoG3Dw2NcDSqDdyYUJqUEh3s+SqCYoA2vUGmuyjYIXqBjyfXcS
X-Gm-Gg: ASbGncusqrebT/nugrdvZBKGDMxeGsF42J4u+4RDRsPhvxCki/0p8+nBt9IC45MvlvJ
	mA/4j9z0DmvN3VdOFZAgdCcLiQKu92HQQV2m0m0rHROK0I5e8nPAPZ+fZNYFCAqWS5PAGczHwsT
	AYcxeIBdnUsCVxozMBZV97Oh3R3dozUG+t+a5w7izs0CoyP415gpn3t7Fz8CisesOpoBOmcfSX6
	ev1Uk1ZXBb2WW8EEDC8Pf4Kcc6JMbAapnqTiP7ZbJiuOEPNeTVv/5siUhdFTSDLrKkVQR+gce/Q
	pFN0h46/BfuOHLP5zWY=
X-Google-Smtp-Source: AGHT+IERboDcf6Xyz7qVGGA2eazNY2EkCDQHXIP7NVNDdbPYOTHWhc17E9ql7P5C+brUdZAZi/tM+g==
X-Received: by 2002:ad4:5ecc:0:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e65c9cd74bmr62632656d6.16.1739461363852;
        Thu, 13 Feb 2025 07:42:43 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31fdsm10541066d6.69.2025.02.13.07.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:42:43 -0800 (PST)
Message-ID: <7ddbf418-e8c2-4d2a-9495-3a1cce2ddb3e@gmail.com>
Date: Thu, 13 Feb 2025 07:42:41 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Roaming questions
To: Denis Kenzior <denkenz@gmail.com>, Alexander Ganslandt
 <alexanga@axis.com>, iwd@lists.linux.dev
References: <7b7d342f-0487-423b-86d0-fbbf5987ecfd@axis.com>
 <9eb9d215-8a21-4d82-9da7-50077dd63e13@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <9eb9d215-8a21-4d82-9da7-50077dd63e13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/13/25 7:24 AM, Denis Kenzior wrote:
> Hi Alexander,
>
> On 2/13/25 9:01 AM, Alexander Ganslandt wrote:
>> Hello,
>>
>> I'm looking into different roaming solutions and currently evaluating 
>> iwd, which seems promising so far! My use-case is a device live 
>> streaming video while moving around large areas, and the goal is to 
>> do so without hiccups in the live stream. I have a few questions:
>>
>> Looking at station_roam_failed(), it will schedule a full scan if the 
>> previous limited scan failed to find a better BSS to roam to. A full 
>> scan on our chip takes about 7 seconds, which is often enough time 
>> for the signal to get low enough to deauthenticate the station when 
>> you're moving. It seems to me that a better approach would be to 
>> schedule a scan for either the "known frequencies", 
>
> The idea is to use neighbor reports when possible.  If neighbor 
> reports are supported, iwd scans the frequencies in the neighbor 
> report.  Otherwise the limited scan uses the frequencies that iwd 
> knows the network operates on.  If the limited scan fails, then iwd 
> falls back to the catch-all full scan.  The hope is that falling back 
> to the full scan should never happen in practice.
>
>> or all non-DFS frequencies (since passive scanning takes extra time) 
>> or some other popular group of frequencies that won't take long to 
>> scan. If we're lucky there is a good BSS in that scan, otherwise we 
>> schedule a scan for the rest of the frequencies. In the worst case, 
>> this should be identical to a full scan with minor extra overhead. Do 
>> you have any thoughts about this from your side? Is it something that 
>> could be accepted into iwd or could it cause issues for other use-cases?
>
> If you find that full scans do indeed happen when roaming, then 
> introducing intermediate limited / non-DFS scan(s) prior to the 
> catch-all scan would be just fine.

This is an area I want to improve since we do see full scans routinely. 
Not because we didn't see any acceptable BSS's via neighbor reports, but 
because the current one was simply better. Likely another limited scan 
using the very same neighbor reports, just done later, would result in a 
successful roam. But its tough because you can't always the APs are 
sending accurate neighbor reports.
>
>>
>> Another question is about the "CriticalRoamThreshold". There seems to 
>> be a config for this and some functions for lowering and raising the 
>> roam threshold, but I can't see that they're called from anywhere? It 
>> seems to me that only "RoamThreshold" is used, or am I missing 
>> something? There's also a hardcoded delay of 5 seconds from the point 
>> where the roam threshold is passed before a scan is started, is that 
>> just a "hysteresis" to not immediately start a scan if the signal 
>> temporarily drops, or does it have some other function?
>
> This is currently used with the Affinities property on the Station 
> interface. For now it is only useful to lock the station to the 
> currently connected BSS to prevent roaming.  For example, for the 
> duration of firmware upgrade or similar scenarios.
>
>>
>> Thanks in advance!
>>
>> Best regards,
>> Alexander
>>
>
> Regards,
> -Denis
>
