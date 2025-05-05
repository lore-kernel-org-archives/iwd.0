Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463FF24BBEB
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448762; cv=none; b=p2h9y3g9/HZM7JAKZNrjjpKF0dZSOqi6BOcsd4GOqX+2bK9OFblhw0a3QLgBYqBx0cyKAetRA2F2vZZoGI1rECjTMyMRaqfIl+gDit8Hw3pCYII7Qgo/RO8+kdEa+pFlLvssEPlVoGV1Skhi7W07VbXqRRaWJARSSv8+I5f8owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448762; c=relaxed/simple;
	bh=puv7rgAsEzF1dFI1NMwDA0nW+drBpMThmSHUdgCiOFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWh7LJmB0qZe08XEXmd1LJcLEPGtZGpNFvXIWYP3+8HXBXvQtdNNZPe36dxyLdeF6SaebNcvUkp9UU37VLbAynjbHPrdiLP/rblV38CMfAEwH2X1baZCzUV+tBVc3B3TjnanjbHxVltIp6Q8DoN02PhO6uNbgXCMgS3LsG2XrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJqR3i4o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJqR3i4o"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c336fcdaaso48380995ad.3
        for <iwd@lists.linux.dev>; Mon, 05 May 2025 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746448760; x=1747053560; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8Kwkbw1d8GQ9t9K9z9C6vyqLweNNvZzaRrv/5VIuoA=;
        b=iJqR3i4o69ik11ywXh1d8cg3qJ7Y5qNsv9af84R7SixDjfiDvDxlt4lxSlrXs9Tj9i
         eKu43L9IWPJdoawFpwbAFKR9SbLAguQnRH8P9HIgqyrONnuDzmEIaT6oeWRwM6fGATnd
         V+baMdmgJAiu57sIykSXkHSbGBaCmZQ0vmDopNLzd6rU2/5bKnUHgo5Iewb5OYAGKHLA
         JT+zIt3wZ6JS/itXuGVz3V/DaSBXH1gMsyHG1HUDiuaiKzjOi+MaW7tPtmPUydVqmIzq
         WHIX3Q7UHQ9C2sx+6bRSbQvGt/RJQ5eT/AawxfFmruycQyb8kLuPJdE+jCi52PAV3Nuj
         hJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448760; x=1747053560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8Kwkbw1d8GQ9t9K9z9C6vyqLweNNvZzaRrv/5VIuoA=;
        b=NEk9dz2fmGpO7kCobaE07aaZBWfbJfp1t7GmIgYzFpV1O1Mwii0hlUMTbarYLkbTp+
         r5uKi/VyIMKWa7l8NpcGk0AKpLonclMtgQNltzy6t3j7ceHBY5MTTZA3+r+XIiyCb/GM
         Rcw10/9SwUE464dhf5EojJ6IiA8QTgc5X8aPZn7PT9AUH6ZXtb81xk85QncZ/+Jzp4ty
         lUKddijY3e2dQ3qO6J2O8V6EKBI2YWwHzv/3XzQoOvwti/ZANDfLkGORtJvpF9lPzEi6
         lmZRAkDK5hHrfiwqiNjYH8x5eQvRnSV9+oN+sGNWdAnQRh6NIAe3LlFm8NsJkQ+YgpWY
         6Vpg==
X-Gm-Message-State: AOJu0Yzci+9bwY0he49HfOJQKvdYNc3lvNUYEF2p/ua/xWF953sdScDK
	i+2NwAgcjKDf1kFX265KYDQ7fuQNtgdDsoOzy3rxN1RABoTcuHas
X-Gm-Gg: ASbGnctm+ug3WnfPhVyC/Sz6y0bjMCfpOfF+Ng2aev6sAMvDMea+cNyh8M2vtoNrYsu
	riWCojZetqi3NRHnAjuP2kKJbbtJXZZWoIHw0w4dGtEA+LeHPN1jbqSY4ckD5wuxsCyfKDh4/0a
	pwgYiZFJpyv7AaxskWbgemQx187Cogx5zmeSBrVUTD8hZACir3lBUbpQ76vjQlt8nwCWv6HB+ek
	Jx18v2QVKx6fksTcis/kRzHMnZ6F9j+2vmyG4HlHH8Yl8O53PWkTlWOKEOoG84iJk+0r/ejgV3q
	L7kwYFLhi5HwU6pb7C14iwBc29jmLX874pWdzLNpVGj6qvZE+MrnDXAg2/KyBG5M+SmV/DoIqtN
	+NVJeW4FkAvdtIe0c6gY=
X-Google-Smtp-Source: AGHT+IFlsMFNTrW5do8fKUtdy5fANOELoBfjfL0kvVwZ7ZoPtNd2Wi1czD1s+n8WrfpRvYQrM7d8SA==
X-Received: by 2002:a17:902:e78f:b0:227:e74a:a066 with SMTP id d9443c01a7336-22e1ea27583mr110966445ad.28.1746448760194;
        Mon, 05 May 2025 05:39:20 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb56sm53195165ad.111.2025.05.05.05.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 05:39:19 -0700 (PDT)
Message-ID: <4c9c290a-9c9c-4956-a5d1-b0eef0a7dcf2@gmail.com>
Date: Mon, 5 May 2025 05:39:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test failure in 3.7
To: Marcel Holtmann <marcel@holtmann.org>,
 Andreas Radke <andreas.radke@mailbox.org>
Cc: iwd@lists.linux.dev
References: <D9NMMJZ63E59.YC0XX4QP9HYU@mailbox.org>
 <5595AB40-CF63-4118-8DFA-3FFEAA091F5D@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5595AB40-CF63-4118-8DFA-3FFEAA091F5D@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/5/25 4:57 AM, Marcel Holtmann wrote:
> Hi Andreas,
>
>> the new 3.7 release gives a test failure compiling for Arch Linux
>> using gcc15:
>>
>> .. contents:: :depth: 2
>>
>> FAIL: unit/test-storage
>> =======================
>>
>> test-storage: unit/test-storage.c:41: test_short_encrypted_bytes: Assertion
>> `__storage_decrypt(settings, "mySSID", &changed) < 0' failed.
>> TAP version 12
>> 1..1
>> not ok 1 - /storage/profile encryption
>> FAIL: unit/test-storage 1 - /storage/profile encryption
> it works for me. I checked on Debian and Fedora on x86_64, ppc32 and aarch64. What architecture is this?
>
> Can you check the return value of __storage_decrypt().

The return value would help, but I also just sent a patch which skips 
this test if AES_CTR isn't supported by the kernel in case that's the 
problem. I also tested this in an arch docker container without an issue 
fwiw.

Thanks,

James

>
> Regards
>
> Marcel
>
>
