Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09A848A
	for <iwd@lists.linux.dev>; Mon,  5 Dec 2022 18:48:41 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id v70so5720797oie.3
        for <iwd@lists.linux.dev>; Mon, 05 Dec 2022 10:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbhBsgyR4NsgI3zLp6gtKTabVnCVA5w/13/66LjP6ns=;
        b=HzZF3FkeUrAGblYtSmxDlgOBWQ4R5ij65UPXtkSaGhnWPgFmcgKfJ6IvTo/vi3Ge3m
         JZQuxK3ojuO289NPQbYWQrI9/330b1RGYxOUJxJq9AwdlGRPYJtic57PvMxn/oUF5n13
         s6yt4ED7zjGvSCQiCG+saVenU3F/6ARrnCReiaCvCMln4eXl62zR4E23K9KE+/Rb0G1c
         5AAK4kNEZTUN6EOL+Fa0NTSKcTzugKCe2G7R/WGt9kHHo0qcescd99LZQi+7XgayqsIL
         5qk9cUMFda80Um0lx5TGts2PD5RP04br4HvXZoUwYr67VvNCUZYav++OE4Vm4p3o0rxD
         yJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbhBsgyR4NsgI3zLp6gtKTabVnCVA5w/13/66LjP6ns=;
        b=2C5bH5gs0K9NgvJwIrRErBG5yUu/0VnqwWtXobcGfVwH6cMLCCCH2F1gwpFgh3xCWL
         9BDh02wR0eIWXny5uhroksyoo33dSK4Tz8NP01qzE5UH9p+GeSk98eqAynLFl2oePJfG
         z9WvcMHrICLvjkKkX07/tP2jYc/38HYxBFLKrhvfzfuvendaJ16tduyFGijUWqAYeHJh
         IrgVPcIkHW/uoNNCdJzdWij8NQTV1uUc0o6VKDhrdk+U/qcshiD8ztYgjHVOC6EuokXF
         ulzsq+Jv6lNr1lhLTqExIz1qbU6oSGaKm5+FIzEnE9iyZ4R+6BdO7eJ+VQq4d4iLpiN+
         kzkg==
X-Gm-Message-State: ANoB5pksdDc49Pk7ZLCdFXSISsuvDZUsPBoeaGmhPvVOtuNxDiVTInjl
	64lo0YaJnh4vRo8KgFmQIM4=
X-Google-Smtp-Source: AA0mqf7RT3azGqKEZGBO2DCX/LYsd5FcVDNLDNqvYw5GgZPxhxFfiKK3TWeOUkjFryLgz+Ot56wM+A==
X-Received: by 2002:a54:4513:0:b0:35b:f345:7fb4 with SMTP id l19-20020a544513000000b0035bf3457fb4mr6782668oil.210.1670266120996;
        Mon, 05 Dec 2022 10:48:40 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j92-20020a9d17e5000000b0066c3bbe927esm8127382otj.21.2022.12.05.10.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:48:40 -0800 (PST)
Message-ID: <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
Date: Mon, 5 Dec 2022 12:48:39 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WPA3 SAE passphrase limitation
Content-Language: en-US
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: iwd@lists.linux.dev
References: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
 <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
 <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

On 12/5/22 11:44, Emil Velikov wrote:
> On Mon, 5 Dec 2022 at 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Emil,
>>
>> On 12/5/22 10:19, Emil Velikov wrote:
>>> Greetings list,
>>>
>>> I was playing around with a router using WPA3 Personal (only) +
>>> CCMP-128 (AES) and noticed something odd. Namely: the 8 character
>>> limitation imposed by WPA2 is enforced with WPA3/SAE.
>>>
>>
>> What 8 character limitation?
>>
> On all the routers that I've tried the WPA2-Personal passphrase must
> be at 8-64 characters long. Anything outside of that and the router
> will refuse. Although I admit that I'm not aware if that's required by
> the spec or otherwise.
> 

Right.  8-63 actually and it is mandated by 802.11.  The worst part is that for 
some reason they mandated ASCII only as well.

In WPA2 the passphrase is only used to generate the PSK.  Hence 802.11 refers to 
it as passphrase -> psk 'mapping'.

> On the other hand I can use a passphrase outside of that range with
> WPA3 only routers.

This doesn't apply for WPA3 since the passphrase is used directly.  No need to 
generate the PSK.

> 
>>> Whenever I try to use such a passphrase (via iwctl) I get an error
>>> "Argument format is invalid".
>>>
>>
>> Refer to crypto_passphrase_is_valid() for what we consider a valid passphrase.
>>
>>> I realise it's not the best practice but the exact same router just
>>> works with my Android Pixel phone.
>>>
>>> Would anyone be interested in fixing this bug? Alternatively any
>>> pointers where the validation happens would be appreciated.
>>>
>>
>> What bug?  In theory the passphrase can be anything for SAE-only networks, but
>> since there are plenty of cases where hybrid networks exist, managing separate
>> SAE and non-SAE passphrases becomes tricky.
>>
> 
> Whenever I try to use short passphrases ("testing", "foobar" or
> "foo123") with a WPA3 only network, IWD fails to connect as mentioned
> earlier. I don't have the spec to confirm, but this sounds like a bug.

Just a design decision.  When we started WPA3 was still rather uncommon and 
hybrid networks were (and probably still are) typical.  Since you want to roam 
between WPA3/WPA2 access points, enforcing the same passphrase requirements made 
sense.

> 
> Can IWD detect if the network is WPA2+WPA3 or WPA3 only?

Not really.  You can have a network composed of WPA3-only, WPA2-only or 
WPA2/WPA3 hybrid APs.

About the only thing we can do is 'assume' WPA3 when:
1. The user entered a non-conforming passphrase, and
2. The current connection candidate is a WPA3-only AP,
3. Connection succeeded

We'd then need to make sure to set the WPA2 transition disabled flag and make 
sure we don't try to generate / or save a PSK.  The transition disabled 
indication would make sure we can't connect to WPA2 APs in the same network.

> 
> It so, would it make sense to omit the `passphrase_len < 8 ||
> passphrase_len > 63` restriction in crypto_passphrase_is_valid() when
> the network is in WPA3 only case?
> 

See above.  It is not that simple, but can be done.

Regards,
-Denis
