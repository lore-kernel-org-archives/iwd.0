Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10F25D549
	for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757408; cv=none; b=W+PItupUuAlg9Ozd9NMtmdt5LVJHh/CasIz1p/26hKiwTMAsBEvAl5v44yCXRlHasx7XdUyQJwEaQ2+rmeg2aXNHM72OiT1SHu0kem9Qp7vHjyEUMCBuKOQNto0lkDt5XMi4Gc80RCjfYT4lT1FaBYRU3HKhViJlAAf2Oe0GbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757408; c=relaxed/simple;
	bh=FQS/P9U8Ooxq76xsmQC1kHf3Um176szkhS2JJXYENI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdThnQ/Uobw9PXtNcsSD82wKm/fF1i1kv0IRnYPGD07QgKmOPVwtWLWEGSWxCFlMzU/vPBxcoAVHL2W4nUsJ+/iTMNVSp8aP4Z5j1/3XdtvQW1bCC5h/FSSMhpx3zpVg0gBYvR1Naej2zhJDKyZ1i4m5diNe2fm7mwGHQdMJCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAL7Mvob; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAL7Mvob"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2235908a30aso8160315ad.3
        for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 07:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757406; x=1741362206; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4ppqSxWTilI8Bnh/mwoM0FlIf8d89ie2KUXEwP+GLI=;
        b=IAL7MvobJAGyFZF27NbxoVEvm1/naFpdAFnvdtafrnsbpguXN202jZ5pefdlcIEAxD
         WelPcYUc/97qROVgKY/doYSaGM1flD8yKijeeiMcry+LzcHxYhtOM6f0BYPcCBqZM5JY
         5bzr122vFLX3Ap57DeEZR1A7BC9JquviccLbMQOsawNBhZfBju709LAJSwQG0zKnqTWF
         g0Focn1Hd1g3CyZ8mmCyOhKypuVSD43mAwiOmq2ITMaATlWMYTW7Kq5Tsru9AN3Y6+C0
         rl0VSliKg/By++rVW0NlHFDjpfqh7WooawTmutRKj6CS6/0Axsy5TFs9MQH8UpmHKgwy
         SWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757406; x=1741362206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4ppqSxWTilI8Bnh/mwoM0FlIf8d89ie2KUXEwP+GLI=;
        b=KebY+jISqcRK0IqDfiQ+B2Yl6nK8uG+rDyZTDlaq2GNqkZeHXctX07ROQzC0p7pSz6
         Nj1ntqQr3Je3m7vFY6NyngUNlHmBLfm+SbP9uNmyL7D32qSEtiQeWhmCyVqOcjt9yu3u
         1x8Pqtl90x8mcM5MNCGQmBBafaYlmnVDYu1+IjAyC47GWYzakS9vDK1anSIvzn5zpL4G
         +1P90G+IgJU9WKE6frUDxsO9x5WAUR30awR/zoNwpeCqrY9hIkFivjLvnseiq3qygCg/
         jaUia5GFgVNapLvbrZfEF/QhkDrqV88de15sXDWlZxT+VpQmSJo4/xD2x5gG3iQ2no69
         vMpQ==
X-Gm-Message-State: AOJu0YynijxFJfHnAQU6exaghZedzR/UtFk7hAoP+nWcwIlhTZohaJpN
	muTynDCxhk2BUSSC+rhu6sADl6++h9hqWrTGxU1Z+namilW8VrKo
X-Gm-Gg: ASbGncsr0XD7puWRNYnNf4JUYwkOeF8bSMMtcw7MRhxqzOfPxEcQhuHxn/MDM36GmXK
	9gYgEB4/c6sAQxaMotEFxQP/GtY2sAinCaElOtc+DCvx0AQPDF6sKB/QG4oztIJkHQSI1X5Q+l5
	/OA4ivOmipzxBhuCMhYxaKdkUX4uqcXkK1EScucWEQ2WMQF8Gi97myxVgF6QRRRwikSpVe88GUa
	ayIsz/QIjOpDZModG90/XblxXif+ftP+O7PdJmQmTxcfvnl3RL9yxqqiseWhZ9KkjHrsqpKZTgf
	kYX4nJgL8me6VC+jbKC6PO9OjRRiJOmNAGhRdqGEeI/dM4DLqsG8lGh9f7i9rIQCZS/v0zPJiuA
	+wvu3
X-Google-Smtp-Source: AGHT+IE3L9BDMEzuUxYPasuo7HktXNVFVJyA3mESzUuuPI/NYhT9tJDVXaCBJHzHjKZGAbdUDiS++A==
X-Received: by 2002:a05:6a21:1518:b0:1ee:68e3:ff45 with SMTP id adf61e73a8af0-1f2f4e4c740mr7779222637.35.1740757405822;
        Fri, 28 Feb 2025 07:43:25 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de37c13sm3104574a12.34.2025.02.28.07.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:43:25 -0800 (PST)
Message-ID: <8345a386-9cbb-4dcf-9b31-8e211bd0fc85@gmail.com>
Date: Fri, 28 Feb 2025 07:43:24 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] netconfig: Global option to send hostname with dhcp request
 for all networks
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: iwd@lists.linux.dev
References: <CADXxVS+UQfrbWFfsDnW1QvkpvmEnkxMdv+OPBy=XpPXEFdcU8Q@mail.gmail.com>
 <2c244463-921e-42bc-8618-aea86e28d075@gmail.com>
 <CADXxVS+=KgaaehtvzQUZXcECmGquvdkAiqUuRPnCmugdU0MqWw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVS+=KgaaehtvzQUZXcECmGquvdkAiqUuRPnCmugdU0MqWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

On 2/28/25 7:21 AM, Bryce Johnson wrote:
> On Fri, Feb 28, 2025 at 6:58 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Bryce,
>>
>> On 2/27/25 1:42 PM, Bryce Johnson wrote:
>>> Add global option to send hostname with dhcp always with
>>> [IPv4].SendHostnameAlways so the first DHCP request will include the
>>> hostname on first connection and don't need to modify the .psk files
>>> to add SendHostname after they are created.
>>>
>>> ---
>>> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
>>> index 4ba7b4e7..4f473e07 100644
>>> --- a/src/iwd.config.rst
>>> +++ b/src/iwd.config.rst
>>> @@ -429,6 +429,11 @@ The group ``[IPv4]`` contains settings related to
>>> IPv4 network configuration.
>>>           will limit the number of access points that can be running
>>>           simultaneously on different interfaces.
>>>
>>> +   * - SendHostnameAlways
>>> +     - Values: true, **false**
>>> +
>>> +       Always send the hostname in the DHCP request for all networks.
>> NIT: You could probably just shorten this to "SendHostname". I
>> personally don't mind if settings have the same name between main.conf
>> and network profiles.
> Thanks for the review. I'll push up a new patch.  Looks like I
> probably should have done it in 2 patches, one for the doc and one for
> the netconfig?
Yes, Denis prefers splitting up patches per-file (when possible).
>    Is there an order of preference if in the main.conf
> SendHostname is true, but in the psk it is false?  I assume the psk
> one should take preference?
Yeah I would say if its explicitly set false in the PSK file, that 
should be the priority. Otherwise use the global setting.
>>> +
>>>    DriverQuirks
>>>    ------------
>>>
>>> diff --git a/src/netconfig.c b/src/netconfig.c
>>> index cd19217c..5959a5ac 100644
>>> --- a/src/netconfig.c
>>> +++ b/src/netconfig.c
>>> @@ -375,7 +375,9 @@ gateway:
>>>       }
>>>
>>>    send_hostname:
>>> -   if (l_settings_has_key(active_settings, "IPv4", "SendHostname") &&
>>> +   l_settings_get_bool(iwd_get_config(), "IPv4",
>>> "SendHostnameAlways", &send_hostname);
>>> +
>>> +   if (!send_hostname && l_settings_has_key(active_settings, "IPv4",
>>> "SendHostname") &&
>>>               !l_settings_get_bool(active_settings, "IPv4",
>>>                           "SendHostname",
>>>                           &send_hostname)) {
>>> @@ -391,13 +393,20 @@ send_hostname:
>>>           goto mdns;
>>>       }
>>>
>>> -   if (send_hostname &&
>>> -           !l_netconfig_set_hostname(netconfig->nc, hostname)) {
>>> -       l_error("netconfig: l_netconfig_set_hostname() failed");
>>> -       success = false;
>>> -       goto mdns;
>>> +   if (send_hostname) {
>>> +       if (!l_netconfig_set_hostname(netconfig->nc, hostname)) {
>>> +           l_error("netconfig: l_netconfig_set_hostname() failed");
>>> +           success = false;
>>> +       } else {
>>> +           l_debug("netconfig: Hostname '%s' will be sent in DHCP
>>> requests", hostname);
>>> +       }
>>> +   } else {
>>> +       l_debug("netconfig: No hostname will be sent in DHCP requests");
>> It probably seemed consistent, but l_error() actually doesn't include
>> the file/function which is why those all have "netconfig:" in them. For
>> debug prints we actually don't need to prefix with "netconfig:" since it
>> will always include the file and function name.
> Will fix this as well.
>
>>>       }
>>>
>>> +   goto mdns;
>>> +
>>> +
>>>    mdns:
>>>       /* If the networks has this set take that over the global */
>>>       if (l_settings_has_key(active_settings, "Network", "MulticastDNS")) {
>>>
>> Thanks,
>>
>> James
>>
