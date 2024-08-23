Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CC188A25
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429373; cv=none; b=YqD5ApO66g9YnRvPSHGtU+WUhxA3kEwlkqwEt9ZRWxNekbS/fNsxE/bfFwuohmUUdrd+6PEKz+gDB8jiR0cTDbly2EHyoXTEx0ed1pu85V3SxFkPPOe0yOx27PkUuiBXc66zpCI2kFYLyXT1zrJ51IOJlCPCDQbvb1J11nWpLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429373; c=relaxed/simple;
	bh=ont9IEIBPC1CBi5H9jGwA4fp3jF93K+HhPwx0/+fZbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XUekvZOLJs39TTBQHxTCYh5RBo/i9j7mlEqF98RZ12IrRfBwi1OwcwxNLo7qWV09QtPRH5fhT7o96+nGkj+b6zrUb0qOwhaDgfG7eLY4zJIjDq9V5dh24am1MGsaNO76fVRcQZVArVXi41f8QiacfsyNdF5l4Rd42o7wHPze6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLHQJE3N; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLHQJE3N"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45007373217so26475841cf.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724429370; x=1725034170; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdzWVWh5X+3pO5NJJpVmfoGj0pfZ76OocOZQtLz/z7U=;
        b=hLHQJE3NZMVrTt9H1GEEq8fUx4A/th02EYY9VE9wqQCYpe3YIYSY+SkMKSGgRm3rKR
         dFDfGVfb5BmO2IHTkwzKYlz4qvI0g5Sr1MO7wHQ/6I7sx5r/CB6Ndh4yQy84VpiihhK9
         8GMQoVyfPHaG15rQJIHJyCl9qvmzL/iey4SE/n93kR5NVPpjSNzm4VPAb5d4dZMW7mDI
         CEcEuUtgCT2plaekmm3gPlr8OYi0jOXc5pxszYKxuOpgVp3XDqzmpet6fgFUjvcSSIu0
         cAV6UnYH5eCGT3lH1T/eCdSaWPcnRd+FL3ux/Pr/geVd3YR5XOe6tgg1jLhQ0SZf/IHC
         hZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429370; x=1725034170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdzWVWh5X+3pO5NJJpVmfoGj0pfZ76OocOZQtLz/z7U=;
        b=Ogp6ZkHLFntXwkgRc0hMo50jYSlTt/xXvph7ybsgUCVlAvVk2zlPrgNn8MKuMCiZ/c
         EQJkE2ozNzOXqjpJpAKGHqhLuPxpnIe2VO4ihsHsmOg6q0LqFtZIUTFHRPrdmltcbT+3
         vCBcnnPGzwEitEFu+d65G9Sqet+ZNG/ASW1HILnyR5ayC78+T3QNPZ2Z4F3rKy2g0DHq
         W+4R9ZTYPRo5zwSCUB0N0zv1HFSizCayqrgSJfdygenHohFwivnk7L6FH0hqxKtUKjPH
         Z+UfWdB3/RMhekkasxBeaOnMbpNrSWv+GSATeDAm5Ixd8Wkh74zW1bx25zQOFNF12Mz0
         f38Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj/XzCKnVIAn/CAsNBrvCaW4CK0rRFw2lmqVaHj6YPskCfPyjwqFXpoHKry4Ccn2hOF9s=@lists.linux.dev
X-Gm-Message-State: AOJu0YwX9PjA7AB/eCOSRycSDGlIIIcJwNHhdtYzhMLd/rq50ObLGRx4
	fSdnJoNZ4Hi4A74slWnhJFq3R+Xgw+P9Ve8jVzlDQLQjAJpAHnb3
X-Google-Smtp-Source: AGHT+IFnd+hSTNcM6aoGVLWDNvj31+eTmPuEv7xdT1hvfhPXu+KVZAAqYWn+OKe3gWWLegnqH8mkPw==
X-Received: by 2002:a0c:f20a:0:b0:6c1:637e:b5c8 with SMTP id 6a1803df08f44-6c16d444277mr54235706d6.5.1724429369539;
        Fri, 23 Aug 2024 09:09:29 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd0afsm20017086d6.120.2024.08.23.09.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:09:29 -0700 (PDT)
Message-ID: <a5aeda36-1618-468d-b796-b8b06dd68f96@gmail.com>
Date: Fri, 23 Aug 2024 09:09:26 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] doc: Document station Affinities property
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240819175151.1310546-1-prestwoj@gmail.com>
 <1ae5fbdc-631b-4bac-a913-2011a7e9996e@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1ae5fbdc-631b-4bac-a913-2011a7e9996e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 8/23/24 9:03 AM, Denis Kenzior wrote:
> Hi James,
>
> On 8/19/24 12:51 PM, James Prestwood wrote:
>> This documents new DBus property that expose a bit more control to
>> how IWD roams.
>>
>> Setting the affinity on the connected BSS effectively "locks" IWD to
>> that BSS (except at critical RSSI levels, explained below). This can
>> be useful for clients that have access to more information about the
>> environment than IWD. For example, if a client is stationary there
>> is likely no point in trying to roam until it has moved elsewhere.
>>
>> A new main.conf option would also be added:
>>
>> [General].CriticalRoamThreshold
>>
>> This would be the new roam threshold set if the currently connected
>> BSS is in the Affinities list. If the RSSI continues to drop below
>> this level IWD will still attempt to roam.
>> ---
>>   doc/station-api.txt | 17 +++++++++++++++++
>>   src/iwd.config.rst  | 16 ++++++++++++++++
>>   2 files changed, 33 insertions(+)
>
> Couple of questions:
>
>> +            Setting the affinity will lower the roaming threshold,
>> +            effectively locking IWD to the current BSS unless the
>> +            RSSI drops below the critical threshold set by
>> +            [General].CriticalRoamThreshold{_5GHz} at which point
>
> Should '{_5GHz}' be without the '_'?

Yep, that was a typo

>
> <snip>
>
>> +
>> +   * - CriticalRoamThreshold5G
>
> What about 6G?
We could add one for 6G as well, I was just maintaining what we had 
today with respect to the existing thresholds. I can add 6GHz thresholds 
across the board in a later patch set.
>
>
>> +     - Value: rssi dBm value, from -100 to 1, default: **-82**
>> +
>> +       This has the same effect as ``CriticalRoamThreshold``, but 
>> for the 5GHz
>> +       band.
>> +
>>      * - RoamRetryInterval
>>        - Value: unsigned int value in seconds (default: **60**)
>
> Regards,
> -Denis
