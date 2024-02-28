Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F415B969
	for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133158; cv=none; b=APAPneOMNLMmIOhV/lkn+1fFGIxJfm5sjW8N9AZT9LQD97mBuGZNGhhs74uch/DySjz3i/lKHnkxGmDG7BfMfFHQSGF2rGnxCaKa8rLtY4DKSY6Q04egkT9NIVGhrsSGjFgpjGLgtdXJsIVWW/RkyFVqmHU79kzzNvRKBr5Saqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133158; c=relaxed/simple;
	bh=X1K0XjKwVG3c4b5aKo2n4lapwqVgwB1aJxowqO2UMFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD47wdWrtPmEA0PTUiSaVeOOf5uxl1Q3cj/IQHtdlAQXLWWyGIbnxZCOb/hHEpsUULRmS5kcvn1wvaptFMBewuP7l+CguDgGsoTBUbDD6wHFP3ncik6W+V3JyRvCaIoGYdvpRfcp6URYd8Fyt+NLhmuDzHUOEq73ANiUx6CdtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TI0k3xcI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI0k3xcI"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42e5e16559cso36242681cf.0
        for <iwd@lists.linux.dev>; Wed, 28 Feb 2024 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709133156; x=1709737956; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxaZ1UzxsgMI12d+1zY9SJoPpZ/57S9wrZ8gYGechFs=;
        b=TI0k3xcIQq7kQX9Pe0VDp3cKsz9F21ctNh919dPHsvuJElG0QS5+TQ4jWx3E6dW1XN
         dh2+9dIQS7A+lDKIJZ/k7p+T0ohqXkLNp0zMSewQFxCtEDvnlySHr4O1UXv7yziLYKiy
         st8F29IM8SiHll/GsuLldkrcdiIA1yYxUzFEC+tJ35t3D7r+ClA3jRAsh3ciaLc0Clvp
         p8Pt+XAu0mUjKd1N3wKfkt0m4GnoampdU3qO4Xmyxf9QtXbSJqkzSQ0WwYDlx0vMhysy
         OnQiGwAdk+VQcbj6dRXPXgmn9us7AyfuyakuYvukog5ZFAOPi5iNW/qf5oYUxCEzV2VQ
         xAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133156; x=1709737956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxaZ1UzxsgMI12d+1zY9SJoPpZ/57S9wrZ8gYGechFs=;
        b=frh2BeiAz+zTq0dUGOGylY7Rel5ES+m7FXV5rvlXRSJ5RM2Lesca4mMfqxGrkzG4Pf
         8prOuu7wgwnlBzRKDxMoQbtD1aE+bJnqeRviBHQdDnGsO4NNYLSVn6fbbFkipHiofDVW
         ufWm+yGgRdMgAOAf8c/xhS3BJ9gwGdbvPku7WDVUsmOltaYqwTtN0XgdWWiXHuAnwcQe
         gfM/jRj3weHKZOq+W1nWY458TRX2Ogc9biE4VFJ9t2uLuiXMLSOYNY7sdWl7jayQk62I
         zr0EeXs87Sb4TwQNaT8B4f5R8vkfQ+oMtf2Y/F10w85t4HILpPmNyD2DYZXoC5a0Lq3p
         4PvA==
X-Gm-Message-State: AOJu0YxDW95PBxBIUuj+CfgLJnbS9rpGxhTX1q74tizFRDs3TilvBrg6
	BCbcZtbwfBDi15FXg6sK8o1AA7iGBLAN5miW9+mrTvc6AKGH/Mfjfriftjle
X-Google-Smtp-Source: AGHT+IGabdxKF+M3f5lQ9X+EsYuLiW4ZzUFcjEWVtUWn9wrWeiw17p8kbgqQfuvw+chF29x9pmDYQQ==
X-Received: by 2002:ac8:5f96:0:b0:42e:b4b6:cc51 with SMTP id j22-20020ac85f96000000b0042eb4b6cc51mr726451qta.12.1709133156237;
        Wed, 28 Feb 2024 07:12:36 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id de38-20020a05620a372600b0078749c88a19sm4648779qkb.0.2024.02.28.07.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:12:35 -0800 (PST)
Message-ID: <4d29f48a-9438-4073-95db-28f5dc8894ef@gmail.com>
Date: Wed, 28 Feb 2024 07:12:33 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: auto-t: fix netconfig to handle resolvconf values
 out of order
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <20240228124018.334892-1-prestwoj@gmail.com>
 <CAG17S_O2k89v3A_DusK8373jcVwxQMD-3bGOYVcasxNj7xsuRw@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_O2k89v3A_DusK8373jcVwxQMD-3bGOYVcasxNj7xsuRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 2/28/24 7:11 AM, KeithG wrote:
> James,
>
> Does this work if the system is using systemd-resolved instead of resolvconf?
This is only a test change and doesn't effect the core code.
>
> Keith
>
> On Wed, Feb 28, 2024 at 6:52 AM James Prestwood <prestwoj@gmail.com> wrote:
>> The slaac_test was one that would occationally fail, but very rarely,
>> due to the resolvconf log values appearing in an unexpected order.
>>
>> This appears to be related to a typo in netconfig-commit which would
>> not set netconfig-domains and instead set dns_list. This was fixed
>> with a pending patch:
>>
>> https://lore.kernel.org/iwd/20240227204242.1509980-1-denkenz@gmail.com/T/#u
>>
>> But applying this now leads to testNetconfig failing slaac_test
>> 100% of the time.
>>
>> I'm not familiar enough with resolveconf to know if this test change
>> is ok, but based on the test behavior the expected log and disk logs
>> are the same, just in the incorrect order. I'm not sure if this the
>> log order is deterministic so instead the check now iterates the
>> expected log and verifies each value appears once in the resolvconf
>> log.
>>
>> Here is an example of the expected vs disk logs after running the
>> test:
>>
>> Expected:
>>
>> -a wlan1.dns
>> nameserver 192.168.1.2
>> nameserver 3ffe:501:ffff:100::10
>> nameserver 3ffe:501:ffff:100::50
>> -a wlan1.domain
>> search test1
>> search test2
>>
>> Resolvconf log:
>>
>> -a wlan1.domain
>> search test1
>> search test2
>> -a wlan1.dns
>> nameserver 192.168.1.2
>> nameserver 3ffe:501:ffff:100::10
>> nameserver 3ffe:501:ffff:100::50
>> ---
>>   autotests/testNetconfig/slaac_test.py | 21 ++++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/autotests/testNetconfig/slaac_test.py b/autotests/testNetconfig/slaac_test.py
>> index 26ae0e46..5aeb730e 100644
>> --- a/autotests/testNetconfig/slaac_test.py
>> +++ b/autotests/testNetconfig/slaac_test.py
>> @@ -81,14 +81,21 @@ class Test(unittest.TestCase):
>>           self.assertEqual(expected_routes6, set(testutil.get_routes6(ifname)))
>>
>>           rclog = open('/tmp/resolvconf.log', 'r')
>> -        entries = rclog.readlines()
>> +        entries = [l.strip() for l in rclog.readlines()[-7:]]
>>           rclog.close()
>> -        expected_rclog = ['-a %s.dns\n' % (ifname,), 'nameserver 192.168.1.2\n',
>> -                'nameserver 3ffe:501:ffff:100::10\n', 'nameserver 3ffe:501:ffff:100::50\n',
>> -                '-a %s.domain\n' % (ifname,), 'search test1\n', 'search test2\n']
>> -        # Every resolvconf -a run overwrites the previous settings.  Check the last seven lines
>> -        # of our log since we care about the end result here.
>> -        self.assertEqual(expected_rclog, entries[-7:])
>> +        expected_rclog = [
>> +            '-a %s.dns' % (ifname,),
>> +            'nameserver 192.168.1.2',
>> +            'nameserver 3ffe:501:ffff:100::10',
>> +            'nameserver 3ffe:501:ffff:100::50',
>> +            '-a %s.domain' % (ifname,),
>> +            'search test1',
>> +            'search test2'
>> +        ]
>> +
>> +        for line in expected_rclog:
>> +            self.assertIn(line, entries)
>> +            expected_rclog.remove(line)
>>
>>           device.disconnect()
>>           condition = 'not obj.connected'
>> --
>> 2.34.1
>>
>>
