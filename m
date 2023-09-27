Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23934CF3
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 16:40:23 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3aec067556dso1383714b6e.2
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695832823; x=1696437623; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RkDpQUjcX5afsuIyCBKjKytwiKkejTWSaCtKevcbwY=;
        b=Ifey4oO67k1fMTBoNenAWfda4zwGawTEv0OY8Lz7n9Z+4Bv5SvpAbQYsffNOLMTt74
         Z4eQsOBh9brwI00/bgWJhiLoPLmJGWwSa6tIuGEV4JFJXBd7b+as5a0f2GYOpxWs0Rto
         r+XjlYe9rK7a3/WN8SVss6csWsN9jyaOLFEeeCIqkFk/e2cMzevFfKLC0oZntuw8Fqqd
         cXN/TSDDx8CrrmR234LRVUTp2Q3O9M73hniUVDpHAOXaNATSNHPcv1957BHxrywc/lO9
         Vfu73SNn/rsUZ4EoCtKuL9fUNMuVLuzB2YAfH54+ToPjlc/2N7d5IcuwTuxhXUEsr9Dk
         wTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695832823; x=1696437623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RkDpQUjcX5afsuIyCBKjKytwiKkejTWSaCtKevcbwY=;
        b=hMYDM+Go+pV4LkXXcIJxcS9FzqZ19KDFdFDfRrUlsu2IgQcKs+BL/TPGqZwhiGd1PK
         GidxfqutPBexG6k4xWFqAJGW9ZzEupE5kBCsbrpW4VDrNEARKwnCb6ycS8xoE5Fi73Co
         RmyzhJP8cVlfKxI5hOiw9vqxBLedYs2MNw7DLOhBXHYuZCp127IFH56zKbfQEnWUgT3w
         4HesOSTlbLLB3s7NTHhXfUPc43XthgQajxg7NquMQfzuhWn0TqG9fLJvaC+sqmeiZOMd
         JrWPKv+Aw9ji+PnoDc/1VV9FslBhL/9ENMEtZXsVz2YY+40QxN93ZLfcmBLc9dtD+ALp
         eIdw==
X-Gm-Message-State: AOJu0YzvmZ/nYHBX+BAi4aUR5U0ram/nqzsm/TTwqoC2qmgYmqr7AhQ8
	lutCd2bvUtgw28ye2V2iMa0=
X-Google-Smtp-Source: AGHT+IHZHioVDdbKCBz9gXdJcQPoLATj/UkAHr+LQPUb0MBJ24Y4wX1EL/DQatGi/T7dxaxZUG2YqA==
X-Received: by 2002:a05:6808:1522:b0:3a7:9e15:fbfb with SMTP id u34-20020a056808152200b003a79e15fbfbmr3032399oiw.9.1695832823150;
        Wed, 27 Sep 2023 09:40:23 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k28-20020a05680808dc00b003a8560a9d34sm297581oij.25.2023.09.27.09.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:40:22 -0700 (PDT)
Message-ID: <ebe072e4-1c39-c1c4-d4a3-7e9cf97b0c8c@gmail.com>
Date: Wed, 27 Sep 2023 11:40:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: James Prestwood <prestwoj@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
 <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
 <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com>
 <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
 <631dd09c-94e1-44bd-88a0-32ecd12f8221@gmail.com>
 <CADXxVSJhjpBk_FcQn_rfK6xB0viR1rRXSiiwr1tSFxi0EYnY_g@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADXxVSJhjpBk_FcQn_rfK6xB0viR1rRXSiiwr1tSFxi0EYnY_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

>> Which test spec is being used here?  I assume something like "Wi-Fi CERTIFIED
>> WPA3 Test Plan v3.4.pdf"?
>>
> 
> Yes, that was the exact test plan I was referencing as well.
> 

Ok excellent.

>>
>> I'm not quite sure what benefit there is in supporting PMKSA for WPA3-Personal.
>> Maybe lessening the CPU load on the AP?  The number of messages exchanged will
>> be identical if I recall correctly.
> 
> I am just learning this now, so might be wrong.  But looks like it
> would it then skip the 4 initial SAE initial handshake messages?
> 

I don't have the spec in front of me, but from memory: sort of.  SAE handshake 
uses Authenticate/Associate frames as transport.  So 4 messages (2 round-trips) 
is the bare minimum for the SAE handshake to establish the PMK.  Then 4 messages 
(2 round trips) for the 4-way handshake.

With PMK caching, you can skip the SAE handshake, but you still need to exchange 
Re-Associate frames.  So 1 round trip + 4 messages for the 4-way handshake. 
That's the best case.  Worst case is the AP doesn't have your PMK info and you 
have to fall back to SAE handshake.

For WPA2-Personal there's almost no point in doing PMK caching.  For 
WPA3-Personal one can skip the expensive computational step.  For 
WPA-Enterprise, one can skip EAP entirely and go straight to 4-way handshake 
step, which is a much bigger win; but then FT is a much better alternative 
there.  This is why we never prioritized PMK caching, but I do kind of see the 
benefits for WPA3-Personal.

>>
>> You're the first I've heard about.  If anyone else is going through the
>> certification process, I'd certainly love to hear about it.
>>
> 
> Me as well, I'd rather not switch back to wpa_supplicant so any
> workarounds would be great!

Oh, I forgot to ask you, is this the only obstacle you're facing or are there 
other tests that are failing?  Strictly speaking we already use PMK caching for 
802.1X preauthentication.  It probably wouldn't be too hard to add this for 
WPA3/2-Personal.

Regards,
-Denis
