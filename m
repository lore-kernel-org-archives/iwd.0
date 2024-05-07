Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C315F410
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091646; cv=none; b=WhD4TZj1HhgTErbIeDUx9DtdcOESmBTiqh0YmQEbsrvrSqXMTUMvhu9+9zZSYgachI8qH9QismdTOH65pUmsZOGOtY16q4fc+Hfw3DaOgtTadOO/3R7MUdl2J1DqDECeOedBK6mQ6lvyR8JpEN7t6XyqCY+aexbrCbQ2faBWaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091646; c=relaxed/simple;
	bh=zGbcGjtBUA41Den5SAqK1/SkbrLb+VKIwhLk/B3o/Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sD8w6KD4SElorYXZ5zpab77LK+rdXf/qohi7BNVgULWcxZObuv4QSttyN1ZayE33aOIMYcoo4kZw4piRIBeAz52ERIOSpHkYKUGAlEzPLracRhkWmutswrICzZo/iywhJM5Hp4n5Aab0TnhgbOuT/I9IyBOiqLX+oE3xLo0Fplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+qgkbnX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+qgkbnX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ee4162061fso1943838a34.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715091644; x=1715696444; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOgZVFbtFr5KasEV1bnnafDbJcAOOuNf4Ions7HaY4M=;
        b=b+qgkbnX0Qoag49fF01FH0U+vhF4/Oj485y5wf49t4C/n2DncFCgXqUTVa6NTpxjbS
         nyNRaA0Z+CbwgmhAyppflVJYoFqZ1fMKBD3/WQL8NpvuSEXpmLrUeqmhM6n7VqHgxhmL
         QPbatsEqbdVR+omOVNECDYK2oPTTVxe93iTNYJgGbRO438hyeDjZZ8kVPqDpPf07eB+R
         /ZP/1qaMsv1az1jgcjOWoOlHQ9lxBda7AxhsX4GCjeE5uQG4ZlE5F3pjJXtn8DumDwM0
         iJDg9QA11D/8HqPAfQBg/ejul9iRU6uxi9qWLloeTMCMJIvM4R9fVSc1Dwq2g4HY1Uog
         flSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091644; x=1715696444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOgZVFbtFr5KasEV1bnnafDbJcAOOuNf4Ions7HaY4M=;
        b=gUL0NZtKWHe97l5b5T7cWuFUXSTdC6Fuem7WS5JPdahpYE79olaXOTLSqU/42ZAPyz
         rMIN+5hzYJx9ZeVTzkUVYJRbAaEl4YBb1fgdi4Tr+Uti4UnsCNfMH06LKkyGPbBrMNC6
         2vby8jWgMsEJEbIypk0BwbIxgXAcH4e+bkKMl/2jOG+suWHztF/BtCJYbvXoH+qiI9My
         UB5Yi1h7o/KGnrGsUnlFLuh09d2AjIgw98vMu+9SATbDrAH+7AnJs0BXI9gPO70gi152
         9uLHN06s6Par7mWpi6iJr/vrn99wwgezSuNHVQL4G/I4y5wZBcU5MOlGM0I4SbrEU7cs
         y8zg==
X-Forwarded-Encrypted: i=1; AJvYcCVxGhG7HXeEQ29surP2yOHsm09Eog/Dy69KIxwT7IKTQ5zfjglnUXKqWeyUxYmxEJWjwi9b2RP2pgqz9OC1ydKZJvjj
X-Gm-Message-State: AOJu0YwzmyxKe7SoIGJHOGKBgMxfukzi+xsSrhrBtFeBeNs7No1gUD/C
	P3++XLqHQHrFwmP2jo+AZBdEItkzBhq+guPzOqF4ZoBQ5fI+sNqX
X-Google-Smtp-Source: AGHT+IETPL8L4eKP8dPmF2a5EjHDrhkaIYF/kRgoEaBrsvEWqlqRGfj9GRlqK2hzN1loUH6DAo1epQ==
X-Received: by 2002:a9d:6298:0:b0:6f0:4847:a984 with SMTP id x24-20020a9d6298000000b006f04847a984mr7521411otk.21.1715091644263;
        Tue, 07 May 2024 07:20:44 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f11-20020a056830264b00b006ea19aa0e4fsm2485667otu.29.2024.05.07.07.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:20:43 -0700 (PDT)
Message-ID: <fe0f8f88-edb4-409d-b72f-867c6f7603e3@gmail.com>
Date: Tue, 7 May 2024 09:20:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Getting list of found networks
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 5/6/24 8:16 AM, Michael John wrote:
> Hi,
> 
> I'm looking to better understand how the list of networks are collected  after a scan is done and get-networks is called.

You can always look at src/station.c to gain full understanding.  In short, iwd 
maintains a sorted list of networks that is updated by certain events.  For 
example, new scan results being available, network connection / disconnection, 
etc.  The 'Scanning' property is helpful to know when a scan is ongoing.  Once 
Scanning changes from True -> False one can know that iwd is done scanning.

> How long does a scan run for? I am assuming the scan causes the radio to go through each channel and listen for broadcast beacons to find available APs. I have noticed when calling scan and then get-networks I can get a different amount of found APs, like either I am not waiting long enough for a scan to complete or there is some other logic that dictates adding a network to the list (too low of an RSSI?). I'm also wondering how much of this is really controlled by IWD verses the radio firmware and are these simply request sent via nl80211?

Scanning strategy is entirely dependent on the driver / hardware implementation. 
  iwd has rather limited ability to influence how the scan is performed.  Scan 
results can and do vary depending on the distance from the AP.  You're welcome 
to try this on your own by playing with 'iw' to trigger some scans.  You will 
find that some APs will appear / disappear from the scan results, particularly 
the ones further away or that have obstacles.  Make sure to flush the kernel 
cache with every scan.  Something like:

iw dev wlan0 scan trigger flush passive <- Passive scan
iw dev wlan0 scan trigger flush <- Active scan

> 
> Thanks
> Michael John
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
> 

My company suffers from this as well, but please try to get rid of such notices 
when corresponding on a public mailing list :)

Regards,
-Denis
