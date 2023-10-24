Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFD1429A
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICsl0MYB"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1e993765c1bso3110646fac.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698161382; x=1698766182; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDvJxz70a6dBTrno5PluH3OAotIBnpXAI3PJtPqWIZw=;
        b=ICsl0MYBlRaVNYC3TauypAYTEcSJewve1T9dJbiuoqCzZhPNQMovyuWDDcEWF0GQRy
         PCNMNyBXvQRg0drdXONxS5D+fI4cGXJG+/cHi0tybS6JqIIZ7k7DzqmJ2InDBDNtcZTs
         tDBAevk89P9yHAGyGEZCUxGAclgW217r4eK0m082wMBY/VyG8yPVCuwXE3BPCOtieoHb
         LF9eg4sp76F5hdRV7wzf9TJlfFcB9t3uZrwocR/EJ9IZoRMXhGYaS4BdlCn9+3ij+ASp
         /Wdebp9piWiS3KQ3olQNmKVJAtm+SGIMTJudc+ZtGC0SrkoaaUgz2ZQJW4lWZAhxZbTR
         Gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698161382; x=1698766182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDvJxz70a6dBTrno5PluH3OAotIBnpXAI3PJtPqWIZw=;
        b=bEWByZAN1pRRCakohISdQG7a1vWEWDAfGfSZyS+5LNyFAy4V1V1jVbyn+ebrl5/wr2
         ogj8yBA023eH7q7d+QPk9umX3VzDUGNHCPmt347ORxo03siLOR40nCYfbI6CMEHbt5eo
         eg5Sg+HZphm6173kZKeQakiRvSqkeNLRNpZHP4ybqHAVXQdPu2j+arHepKZpaYplT09g
         i1mMqMMjzVEzehe+fD2cMkspGEVkQMvk5FNGwmrOZ0WafHfEF9OcakTph6fa3o/HBtc9
         /GNvzai06IR742RX7kKl2dnuEoRKp3XJaZICXHmVPy0wDxJxk3TMddUnr94OXDl60zbK
         w4gw==
X-Gm-Message-State: AOJu0Yy9dcPAnx+HARdBswwm3bVcBgQc4v13VSZcQp753rNR1d3qMgvf
	Hs4FTNrNhRrHuKl3hi4J5YE=
X-Google-Smtp-Source: AGHT+IFPDdfZohHON2cp8+qvmm03HMFFtOXtnRWu5/EM4kjjiF8sJDXj3KGVwf9epjQJoTJ5gMZACQ==
X-Received: by 2002:a05:6870:4d08:b0:1e9:68b5:d418 with SMTP id pn8-20020a0568704d0800b001e968b5d418mr15605690oab.34.1698161382599;
        Tue, 24 Oct 2023 08:29:42 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h4-20020a056870a3c400b001dd17c5356dsm2171587oak.11.2023.10.24.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:29:41 -0700 (PDT)
Message-ID: <5ec949dc-e714-438a-9f70-c59bb8f65fc1@gmail.com>
Date: Tue, 24 Oct 2023 10:29:40 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
 <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
 <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
 <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
 <oo6afd4ygkvv47vthzqlvklqnm3gecjkkvhttrxlrmrqqb643t@6dzpfsigq6j6>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <oo6afd4ygkvv47vthzqlvklqnm3gecjkkvhttrxlrmrqqb643t@6dzpfsigq6j6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simonas,

On 10/24/23 10:19, Simonas Kazlauskas wrote:
> Denis Kenzior wrote:
>> On 10/24/23 07:32, James Prestwood wrote:
>>> So you could set:
>>> [Rank].LowSignalRateThreshold=-90
>>>
>>> Any RSSI between -82 and -90 would use -82 for the rank calculation. No idea 
>>> how this would play out in practice, but its at least simple and not tied to 
>>> any given hardware.
>>
>> No, I was more thinking about:
>> /* Added to the rssi value prior to looking up in the ht_vht_he_base_rssi */
>> SensitivityFudgeFactor=4
>> /* Width penalty */
>> SensitivityWidthPenalty=0 (3 today)
>> /* NSS penalty */
>> SensitivityNSSPenalty=3
>> /* Same as SensitivityFudgeFactor, but for HE */
>> SensitivityHEFudgeFactor=10
> 
> My main worry then would be finding good defaults for these values. Ultimately, 
> unless `iwd` ends up in a place where people install it and get a great 
> experience in anything that involves ranking (roaming, initial association, 
> etc.), the WiFi experience on Linux may have a hard time shaking off its stigma. 
> If many has to modify some config variables to get a good experience, the 
> experience will continue staying subpar for the large majority still. Although 
> having the knobs will at least enable a minority to extract a reasonably good 
> experience.

Well, WiFi on Linux is plain terrible.  iwd tries to make it better, but 
ultimately we're down to only two people.  There's only so much that can be 
done.  The goal here was to describe the parameters we could use to 'tweak' the 
current calculation.  These can then be stored per vid/pid/driver or whatever 
and added onto over time.  If the parameters are not provided, then fall back to 
the (very pessimistic) calculation we use now.  Still better than what we used 
to have.

> 
> What worries me in parituclar here is that if we tune these defaults too high 
> (i.e. estimate rate better than it might end up being in practice) then we might 
> end up associating with the AP that is too far away/weak to provide a 
> serviceable connection.
> 
> I wonder if there’s any place in here for some dynamic component that would 
> monitor how the NSS, MCS and other bandwidth affecting parameters behave for a 
> given SSID/BSSID/etc. as the RSSI varies, and transparently learn these 
> parameters throughout a… session (is that a term?) That way even if the 
> estimation for the very first association is too pessimistic, `iwd` can do 
> better when it needs to estimate again for e.g. a romaing decision or a new 
> association after a sleep.
> 
> With such a scheme in place “training” IWD would also be pretty easy to explain 
> to the users (walk around the area with your device connected to the network) if 
> they encountered problems with a particular AP.
> 

Patches are always welcome.  ML isn't my area of expertise, so I can't really 
help here.

Regards,
-Denis

