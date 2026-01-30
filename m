Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E93590A4
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794613; cv=none; b=kG0LuAv4mqXGdjfzUxF3xtTs7JDHZVUT+zRKjJGT1uS2a4G8CyvIWqXUTQbulCbsiiIpKNueG3ZjS5X+i5xaJQqxd/tSeC5sr6ih4YqWRMBgFzRPyXpKHZBBQvQWSsEZ8Xt8RP7PQxbb45LlQUpZKKfj3W0oIUgyKMfteC4PIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794613; c=relaxed/simple;
	bh=0BEuqxmMslrhjamS388ElPvfBwFsty9iFLF4Huz3DyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jud0bokS9JYso2O2SpjiqjHyfYMAtnN2N79O8t9Zgh7B2gdyIHaQQQbic3UvHS3cfgJNhF9DQ9zEtYjb8vk+riYdSNMvSCaPNQQ6yEcvoGZTz2dsHctU4ZcKAYRRWyo8UVvF3ib6QJU/LEP+Ag3ZFXxirzV7iNBG+ZZWXLif52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULLCnuvY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULLCnuvY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7bced39cfso23879785ad.1
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769794612; x=1770399412; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evLXNf/OB2DJnJ27tlQdWCyZQzQ+OXyzvTTuKQHgI9s=;
        b=ULLCnuvYZrHANOVV4aVrnuIGISep1R1zN19NP+czy0XQnkdH1lNmUD/VWCCYNxIuNt
         yi5N/zc8ud7bEY8uVOTrTnvNnRtnDkpfmid3u8jig0xoztPvr1lEUopVav+gxh+Zf4aT
         qidkn+FFhvQ3lao/uPXYXVlOCV2VG9RoNjai+FuTfHbZqPopZfFy5DSmN2mMoaLD7uyz
         ybMY9OwEaTBx4kXgSL1UdRrdaDqjqRsmA9z9atXxEZo0IAIvlQ9LI1ck76M/EZGh2u6a
         XssjFgJ6Xz4HsyZQSXRRDSk+bcKisCBKzZscyLwGvatIuy+Mi3sQxff6NPkTCRcZpqI+
         KWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769794612; x=1770399412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evLXNf/OB2DJnJ27tlQdWCyZQzQ+OXyzvTTuKQHgI9s=;
        b=hr+WZmsrfw+fIZ5U5PIHEuVNHaoJrdrr5ySjRUesqZsi0QchpTE+xxltN93yWjvXfQ
         IJqRuj+1rzWudEHZA3aJld2fRKgX6FDgGuny+J0LLmCSRNdhe3rVGtN0Atw/UWhoy1Ov
         AhPUE+4VPcB5Nl4hkGHNRSbr6KM1gp2S+bsxaKz5R0mmTZyKKGsfqK+uxZFb/oAKXW/Z
         NUNTLTR0202E2tX9BLsWLu6Y/gKOcedpz5E5q7Knn3uqjXLXQwhnfMZjWm9YABGNl40s
         z7Q7gKNXL+0zokh6Ri2nuxrAbEO4HcRWxm3NhzBCUHiqkAwnRbxxGaBQbiUMSFR+1Vld
         mHkg==
X-Gm-Message-State: AOJu0YwvZpkYRzfv03L1TUKFNzkutl4siOfySRlUBzENVJ9SaakHV5mE
	bsPP7l/0Im4JrKdAwHD8qrtuufMnyU7DdDSvhxfhCeUrR8f/lUKVB9wmEXSRbA==
X-Gm-Gg: AZuq6aLQ2238uwc+/4Kj5388lsA/XxuNjOjQDIuP49TIvl8ff+qE90AuxPwtYWseaJc
	EERsfPyN4/Wu1aGgmsOKRlcZWih7rYRK8MLruFUbl5FS2+uL81epukz/CqnuDSbxvaenImoTkwO
	FkHdrEwYyGzY6tXikY9lKjr5Wa6e1655GZ8S0C2VEf+4bNjx+PjwqnYMp+oa5B454WNgM0iWiHP
	y4hFsDI3fOe9k1C1vIsMwed5azj8VyCjOyWOIu6fmewpfkgalL6JMchOXnnE3VObQCF6cJUgj03
	gSWinMAWSqjyq4Fg3xrwfs22UbElwwRDYfE0hZIwZNxkUgJgKqy1W2U3vT/oOTnRR2DN1aN2AuO
	yieMFFPZmjg6/P/W0cAaqRRN6FxVFfSEIPNliWP3fvkHatg5qxRf19/KVxu6wfk5ntqyRNY3wfr
	JVXO1vGJnZLejbOS13fEze4uPu
X-Received: by 2002:a17:902:db01:b0:2a0:d692:5681 with SMTP id d9443c01a7336-2a8d96df1b2mr34103015ad.24.1769794611668;
        Fri, 30 Jan 2026 09:36:51 -0800 (PST)
Received: from [10.137.43.164] ([209.215.148.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f32bfsm86128665ad.96.2026.01.30.09.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:36:51 -0800 (PST)
Message-ID: <20910906-9610-4d68-a4c4-dcbebd0d95d0@gmail.com>
Date: Fri, 30 Jan 2026 09:36:48 -0800
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
 <4ab7e9b9-be27-402b-834c-3e71bd58a476@gmail.com>
 <CADXxVSKsC=gmYoXk9UiPDfHW0a_MbfKpDc2YYH=qprA5bGNfSg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSKsC=gmYoXk9UiPDfHW0a_MbfKpDc2YYH=qprA5bGNfSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

On 1/30/26 9:21 AM, Bryce Johnson wrote:
> Hi James,
>
> On Fri, Jan 30, 2026 at 8:07 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi,
>>
>> On 1/30/26 7:01 AM, Bryce Johnson wrote:
>>> Hi James
>>>
>>> On Fri, Jan 30, 2026 at 7:48 AM James Prestwood <prestwoj@gmail.com> wrote:
>>>> Hi Bryce,
>>>>
>>>> On 1/30/26 6:43 AM, Bryce Johnson wrote:
>>>>> Hi All
>>>>> We are working to get our product through wifi certification.  Our
>>>>> testing company mentioned there was several negative test cases that
>>>>> were failing where IWD was connecting anyways because it would decide
>>>>> on the security type based on the AP.  Is there a way to force IWD to
>>>>> use a security type that is different than the AP so it would fail the
>>>>> connection?  Can we disable WPA1-only connection or force WPA2 only
>>>>> connection?
>>>> There unfortunately isn't at the moment. We do have a "developer mode"
>>>> by specifying "-E" to IWD and this seems like it would fall into that
>>>> category, support would need to be added of course.
>>>>
>>>> But I'm somewhat confused (and maybe this is just poor test cases by
>>>> WFA?), why would you need to certify that IWD fails when using a
>>>> different security type than the AP? A client should not ever use a
>>>> security type the AP doesn't advertise support for... This feels like
>>>> its testing the AP, not IWD :)
>>>>
>>> I'm was requesting what test case fails and if I could get a copy of
>>> it.  The only thing I can think of is that they want to disable WPA1
>>> for example and show that the device won't connect to a WPA1 only AP.
>>> Or maybe for a product you only want to connect WPA3 and fail and not
>>> connect or not allow the AP to downgrade the connection.
>> Yeah I'd be interested in the test case.
>>> Maybe it would make sense to allow a blacklist of protocols you won't
>>> allow IWD to use?  For our product we wouldn't allow open or WEP
>>> connections for example (but we perform that check outside of IWD).
>> IWD already won't connect to a WEP network, so we're ok there. You may
>> be able to coax out some behavior with the following options:
>>
>> main.conf
>>
>> [General].ManagementFrameProtection
>>
>> network profile:
>>
>> [Settings].TransitionDisable
>>
>> [Settings].DisabledTransitionModes
>>
>> Anyways, lets hope you can get the test case. Shouldn't be too hard to
>> add some support for specific test/dev type requirements.
> Here were the test cases
> For test case 10153_1:  The test bed AP beacons with no security.  The
> test case requires the STAUT to connect with WPA2-PSK only.  Because
> of the mismatch of security protocols, the connection will fail.
>
> For test case 10165_1: The test bed AP advertises at WPA2-Personal
> only.  The test case requires the STAUT to connect with WPA3-Personal.
> Because of the mismatch of security protocols, the connection will
> also fail.

Both of these are pretty ridiculous. They want to test that a client 
chooses an incompatible security type than what the AP advertises.... 
what?!?

I know these are coming from the WFA, and not you... Its just rather 
annoying that they're so adapted to using wpa_supplicant which you can 
force to do stupid things like this. And the fact they wrote test cases 
around that is just sad.

I guess the only option if these are strictly required is to add some 
config option to the profiles that restrict what security types can be used.

>
> I got the PDFs of the test cases I can share offlist as well.  10153_1
> looks like it would not connect, but apparently hung up on the setting
> the STAUT to WPA2-PSK only.  So it looks like I need a way to restrict
> IWD from using other security types for these tests.  If you have any
> suggestions on a good way to do this, let me know.
>
> Thanks
> Bryce
