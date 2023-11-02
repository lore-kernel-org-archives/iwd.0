Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5401C290
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfYI8nLR"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7789577b53fso54219985a.3
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698935598; x=1699540398; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFayLJdPn3IAwgjwc0CZSewMyGfBarJHddmyHgwvsOg=;
        b=IfYI8nLRmfutwA37LeNH9K7yEw7Scb4fMnM9HkrLBtTA7EJC/WLO0EwtLPzD0gcyNw
         SP+1gXThH2xbY13uNbhoCpt5YjhAbZGHmLPqpevTWV69tueICB9DU1gZuT4AAV6WrcEM
         rL9sVYfS3VHQcuM7Df86PVkjYXZq/0HbuRHBuHkRianGwPH3BMi9yZPCl80dKemA5xRT
         9+1TYsL2jm5n0SR11AVHDQslwx1DLSUodzo5ChSwA53tooohqB/fV/b75Nu46AhxLt0d
         RkrCQJQnyURRvlQ9yqnn1EjZ3Mej0YiwgAPlVAZwyMtECFyipGjI2OuQMokELx5Td5gv
         glgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935598; x=1699540398;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFayLJdPn3IAwgjwc0CZSewMyGfBarJHddmyHgwvsOg=;
        b=rNUxpY9WcWuEy3zqj9sazsmA/uAhVxV/4TnTu83wqtV2dFqP/fV0qrEDp4aBokf9jQ
         W3CFijrCb6HCYI5O7sWWsyohB7/rA1SZRskxYsBLhTsHwVJoXYIf4iTzOgO4EmP8vJuu
         WhzVfR8O0IpQQtFFcnW8RQb6ZEGOnzeu40Uh04TnqhZ025M/e3XaW1j78fEVcNNZveIa
         zGcyA8ZWmUd5COMOyljNdTqNYvVwUaulYQtbVSZ1wsj7OgV7jPeqR+8Y1mtPTGRSWo1w
         1UMKCC/+erpDE8xBIJST0lQVp6XxmdR7hjZIvgfoPh8tZl5jY2OaHlx+3EALHQzDfGyX
         bl/A==
X-Gm-Message-State: AOJu0Yy33TcNIiCWHbmjHxGwsFV3VnS2fyR03/+shzfyitLQ0JWKKtx4
	z0VGXvb312R8mU66I2RRBwtU7OINK0Y=
X-Google-Smtp-Source: AGHT+IEOsog1/ElDTBMQBUG1LDSJshZhh49Qa2xeFirlyTWqbbc61OIUIW6DgxmdRnRkyYx5tqilGA==
X-Received: by 2002:a05:620a:304:b0:77a:5112:c1de with SMTP id s4-20020a05620a030400b0077a5112c1demr4518880qkm.6.1698935598383;
        Thu, 02 Nov 2023 07:33:18 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a147b00b0076db1caab16sm2376336qkl.22.2023.11.02.07.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:33:18 -0700 (PDT)
Message-ID: <16ab09cc-0ba9-4c01-9f92-47e05aac2160@gmail.com>
Date: Thu, 2 Nov 2023 07:33:16 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
 <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
 <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 11/2/23 7:10 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> I'm fine adding similar handling that I added for packet loss, except 
>> always delay rather than only on additional events. But I would like 
>> to explore other options in the future.
> 
> I guess the question is, does adding LOST BEACON handling actually help 
> or you're speculating that it does?  I don't mind if we add this back in 
> with a delay, but I'm worried it doesn't actually do anything.  7 
> beacons lost in a row is likely not recoverable territory.

In the behavior I witnessed which was actually quite reproducible at the 
time, and yes roaming on beacon loss definitely helped. It avoided an 
inevitable disconnect.

> 
> I'm actually surprised the driver doesn't give you any other indications 
> prior to the lost beacon event.  I would have expected RSSI or packet 
> loss to manifest itself prior?

There were packet loss events in some cases, and I'd say 75% of the time 
IWD did end up roaming anyways (with a patch that roamed on beacon loss, 
identical to packet loss). It was only the cases when we got a beacon 
loss and IWD did not roam that the disconnect was always inevitable. 
This was the motivation to force the roam for beacon loss.

RSSI wasn't always bad, but it was a very high load environment so I 
assume that wasn't helping.

> 
>>
>> I'm not sure how, but being able to detect if the AP responded to 
>> nullfunc/probes prior to the kernel blowing away the connection would 
>> be great. (like send our own nullfunc frames or something, not really 
>> sure...)
> 
> Yes, the current implementation of this event in the kernel is pretty 
> useless. What we really need is an additional threshold that generates 
> an event out to userspace _before_ the kernel starts taking potentially 
> irreversible actions. Something like a pre-beacon-loss event that gets 
> generated when 2-3 beacons are lost in a row.

Best would be an event like "Disconnection Imminent" (after the 2 
nullfuncs failed) so userspace could start a roam. Like you mentioned 
even if we knew a few beacons were lost, scanning is probably going to 
ruin any chance of recovery.

On the bright side a disconnect isn't that terrible since IWD is super 
fast at reconnecting, I was just looking for any optimization I could to 
maintain the connection.

> 
>>
>> Its taking IWD about 4-5 seconds to reconnect, 3 seconds are the quick 
>> scan and ~1-2 seconds for DHCP. (I need to look at why the quick scan 
>> is taking that 
> 
> That's awful.  How many frequencies are you generating?  Even a full 
> scan should be ~1-2 seconds at most.  And 1-2 seconds for DHCP also 
> seems fishy.  I've tested our implementation to be sub-300ms or so.

In theory only 5:
known_freq_set = known_networks_get_recent_frequencies(5);

But I'm also seeing a random New Scan Results event prior to the quick 
scan. Anyways, its something I gotta look into.

> 
>> long, that seems like something isn't right). So if its at all 
>> possible to roam that is best, obviously.
>>
> 
> Yep.
> 
> Regards,
> -Denis
