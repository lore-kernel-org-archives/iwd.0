Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74377D2E3
	for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibzy6/S7"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d811615efeso426285a34.1
        for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 15:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700954940; x=1701559740; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdLWO6H33ciFX8MJVpmmVXSshCV9udmMNjrqhlMVHL8=;
        b=Ibzy6/S7nRvgW6Evcc1sm2gL85N83PLpq6X/d0jRW6pVZ6N99x+MfCoRxQS1otYJIS
         UZPZdI0/ahIxfTW+boGk8RKH9w0jTey254EIv+N5Lyz2Cr87csPN63YPIHSkzRwxSgT9
         U08FCxBGRuUnR6OruOj14gyyWGkpev1648D22Ek/rZoviIm+C70V+gvH146+y1iXBZZL
         bRuj+KrSLEq5EF8mns2R0b6YGe6iXPSOuj09aDMkjtTvIqbub4VwdyPjgf64J+aBKT5s
         F/dEvmvAAwMhialcNGrWVQdwPRzF+lgK1POtz7i4PXKxyw8CocperyaZytieqvOC08kB
         g0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700954940; x=1701559740;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdLWO6H33ciFX8MJVpmmVXSshCV9udmMNjrqhlMVHL8=;
        b=WzoHHRaLWUn7c2gypH1i9MKcF0EWRePlvzH6WG0lj4TV3zNN9VAwBeLfzDqcrNGOJ6
         nnC8FYIPfqN+Ho35UR0mIp6olezdFYhiuf+kp/tQ6xtDOcD3RCXLZajumhTzy9TMxClm
         3KEJX7frgmcx1x62ySVZAyqS4bvPyDqruGBxP+OY2Fq1WA3OHBaW+RfG/OAI7/gWgWOo
         27dXe0SLN6hCCBsV7aV8JtRfcHE+e+dWLbMExhBJSBLD2/KSupGZFnVYtCp3fyddu2EO
         MI/lgibHwEsnvFTZX141I56QU6N9RMX7l3C23gNnpiEzBFaXvpOW30bKNJqLD0RLXBaE
         cD7A==
X-Gm-Message-State: AOJu0YxXTsysWl1x2UjyafHOeu4AAxjfyAKn0JBn1T0Sn+cK62/Xw4lE
	BSkiK/P4LUKrq2mWJn66IGs=
X-Google-Smtp-Source: AGHT+IFI3drErxIEM1vG7Hmj5uDyCepHO9c0QmbDc+nT59Ko4unif0zStGPg+D0mziotcE3o2WSOIQ==
X-Received: by 2002:a05:6808:13d3:b0:3b5:e67a:7cd2 with SMTP id d19-20020a05680813d300b003b5e67a7cd2mr9258027oiw.8.1700954940108;
        Sat, 25 Nov 2023 15:29:00 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bf4-20020a056808190400b003af56ef1510sm1007121oib.20.2023.11.25.15.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 15:28:59 -0800 (PST)
Message-ID: <0331a3f5-7d04-49d0-b569-3e5fa5b4514d@gmail.com>
Date: Sat, 25 Nov 2023 17:28:58 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: roaming issues on a residential LAN with multiple APs
Content-Language: en-US
To: Daniel Barter <danielbarter@gmail.com>, iwd@lists.linux.dev
References: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

> 
> iwd[32079]: src/station.c:station_early_neighbor_report_cb() ifindex:
> 5, error: -110(Connection timed out)

Shouldn't preclude a roam, just won't use the neighbor report information.  Hard 
to say anything more without seeing logs.  It could be that the roaming 
threshold is never reached, or your kernel driver isn't reporting CQM 
notifications properly, or many other reasons.  What hardware / driver is it? 
Kernel version?

https://iwd.wiki.kernel.org/debugging

Regards,
-Denis
