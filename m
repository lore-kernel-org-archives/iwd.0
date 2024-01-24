Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25137C097
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109683; cv=none; b=DWfQ9xXGV4IS8bE4bTWEYY7BG1AoAt09bNzXrdrI4I9CirYP1SbV51pKZzsftKxgUSaUiESGtXwITPHa2jV9PjeENK+trfemlr1OSFQv5VRua0nW9FXGv4DjllwDQk+0gnm+SAWvsjWg90tARZhfkSlA7jfXq6P4C3C3xN8mseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109683; c=relaxed/simple;
	bh=fE+kBlCK8TBgKiEJXjo1O2iGw4Gsd+zhOKNXEQEWGkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkIQ1kw4C0cVBtIuZpzn2ynmS9LYSohKu/tCcRKe1eMQ7LtTIZfiafkMYxhlCVhKL6iJrqBr97RMuXFEJrK9KL6WD8BHwtG1rkG+l04xl04lmY/qFC95SSg6myc/iyAr+RHCavZyngelUXO9VYBZdLlGY1adueFS+QP0Yzi1rBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URwRKMk7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URwRKMk7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bdcb009730so887264b6e.1
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706109671; x=1706714471; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUrA3GTwarRFosSf6BOsJ+ZwgTSoek1VnsDjTvvdCy8=;
        b=URwRKMk7H1UfZ4khNzMit6aVcG+TUNE6I67tVqoUpPHjE8lKkGrFco0OwcdwEftCPT
         ZnODsbYBGOCa6RLr/+VXJKSBXsIgFb/ClsXUbekiwrd8CJ4jw9QN7Xa4sRQlFw773Zzc
         qPVCcYX4yD7HhSPQ25HOhi33EllRXkpJL5Uet9iRGVFkAlLdoJcW5WDJAKYtQ5/g/KuZ
         RS0bx+3kEDbrf0Lba6urgi80wa6IOZpkv6yQJBYrJK+4o7JW6rcEMn+LHc3JpLUOO6Ze
         JzjY4BGYE3EJ4+cmRuIBCjLATEcIhybllCBR6j4/h1iV/8dalxmXec7Qz2voT6kTjSwU
         0OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109671; x=1706714471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUrA3GTwarRFosSf6BOsJ+ZwgTSoek1VnsDjTvvdCy8=;
        b=XhSNm1mEbTglVbzQlReQK+YDTKzvcE2B2U9ZkH8h6LxetU7pryQ8uQWjV06azyLVhI
         o4GAwikplkkjq2n72muo2xxr9cALLbjpqu8niYb+sup+hjFEFel3kSEhsNV1msi6ggAF
         hsaeamQcnCoMzalOl8wcw4eXczLQSOmvSwT6GcXSdtrp0NDQw0pFzhQ2W4t9gZFdwGA5
         Cc14+CIETY9cHzc36BfpDiBDi06yl39ed3UXS3hGMIVsUFLv827mhNSut7mIJpXh6nMG
         m0suHLevI2jPtSN7mQY0UEAelbxXSsaW+96rDpSGieKoAiAJLSChG2PFVXIQglO8boz+
         41pg==
X-Gm-Message-State: AOJu0Yysh49gjFgeTHCci460VVojrKiPV+jSEz47PfI7n8k1s2e5ldgF
	I/prfpDWgdX17ulIZw9bskosnPTttgIep2Y51yR09LR6iyIlJQrN2c9y7aE0
X-Google-Smtp-Source: AGHT+IEdLuuNe9aaTiLJwP5PUJiFutHMq7qLH9gwJwZ0yPaLZraH0b6JpAtuLlPgX948VM9NzIjWyQ==
X-Received: by 2002:a05:6808:19a7:b0:3bd:bee3:bef1 with SMTP id bj39-20020a05680819a700b003bdbee3bef1mr1964065oib.12.1706109670754;
        Wed, 24 Jan 2024 07:21:10 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j24-20020aca1718000000b003bd4453e5d5sm2618817oii.22.2024.01.24.07.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:21:10 -0800 (PST)
Message-ID: <d3ccf10a-72a8-43b8-8f1c-b5e2a76214ac@gmail.com>
Date: Wed, 24 Jan 2024 09:21:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to Autoconnect Two WiFi Cards?
Content-Language: en-US
To: Fabian Herb <fabian.herb@xtonomy.ai>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
 <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
 <69a80bff-f587-48da-a14e-8897586c93e9@gmail.com>
 <FAC36784-F498-481A-BD35-D3F24269EBD5@xtonomy.ai>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <FAC36784-F498-481A-BD35-D3F24269EBD5@xtonomy.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fabian,

On 1/24/24 06:34, Fabian Herb wrote:
> Hello Denis,
> 
>>
>>> I’m starting to think that it might be easier to add a feature to iwd that does what I want :). But I’m still a bit lost in the source code.
>>
>> Can you elaborate on what you're trying to accomplish?
>>
>> Do you want iwd to connect to two SSIDs?  Two different BSSes within the same SSID?  Something else?
> 
> I want each WiFi card to connect to a different SSID (each consisting of multiple BSSIDs). Ideally I want to add an entry to each network file to limit it to a certain interface. Maybe even better, but less general: If I could limit the frequency band of each interface, I could save a bit of time during channel scans.

The first part should be fairly easy actually.  A very rough approach would be 
to add some logic inside src/station.c station_autoconnect_next():
   - When considering a network, first check whether a network with the same 
SSID/security type is being connected to by other stations managed by iwd
   - This should be easy to do by looping of the station_list and checking 
connected_network / connected_bss members of struct station.
   - If the networks match, just skip it and continue on to the next autoconnect 
target.
   - This should result in each station object connecting to a different SSID. 
Once latched onto the SSID, station will try to roam only within that network.

If you want to make it more fancy like adding additional scanning policies it 
would take a bit more effort and probably require a policy file format of some sort.

> 
> But I couldn’t find the spot in the code where such a decision would be made. So instead, I added a command line option for the D-Bus name iwd registers as, so I could run two instances of iwd, each handling a different phy. WIP is here: https://github.com/cmdrf/iwd/tree/dbus-name-option. It’s not finished, and I’m not even sure it would work in the end or if there are more clashes between two iwd instances.

Well, it could work, but you'd be running multiple dbus instances and there 
wouldn't be any coordination between iwds.  Also, you'd have to make sure each 
iwd instance runs with a different state directory and probably different config 
file (for band preferences).  See 'man 8 iwd' for details on how to do that. 
Another hint, ell already honors DBUS_SYSTEM_BUS_ADDRESS environment variable. 
So you can start multiple dbus instances, record the address and point each iwd 
to the dbus instance via DBUS_SYSTEM_BUS_ADDRESS environment variable.  No need 
to change any code inside iwd.

> 
>> MLO only works to the same AP though, just different band.  You mentioned using a different SSID earlier?
> 
> Using multiple SSIDs and doing the redundancy on application level is only done out of necessity. I’d happily use MLO if it does what I need instead. But yes, after reading a bit further, I also noticed that it only works on a single AP. Waiting for WiFi 8 then…

Fair enough.

Please report back your findings.  I'm curious since I can foresee a similar 
setup (but on the same SSID / different band / different AP) being useful in the 
future.

Regards,
-Denis
