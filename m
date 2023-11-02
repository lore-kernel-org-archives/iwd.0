Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978519BC2
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaWp+4oc"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so533830a34.3
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934262; x=1699539062; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2K0xqazJfalSooXyWYSiuvydNStKN957yeca/5jgirk=;
        b=QaWp+4och3mbnzONr7bKF6vzf5w2kqtgQNkYdTW6i69eapP1H08GKCueSJt40pbExr
         EVk2LI/dnDeI3VhhtSgRHySuvoC6lDOWFNYAl0EQoaAfb0Eyz2ufor8V6Wg0VF1pqIKC
         K2foCi1EzMbBCEk1jMSolfDmbylAO5BFx/y9FTIjyTWjB2lSN1oDUsmBqnnELCIeHKUi
         e8g8yHlWd5FuPeuF0pkTfRrhgW1/3+z7oKh3AX9RlKj01uS1wmjPykRPMv+8lEOvA1uQ
         SgsS8QVTMMZ7K9QWB/Rz+0pXrC0OfBeEhLre23pHHPAF36UAcd9m6A5ToFd5snnjlvFO
         9L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934262; x=1699539062;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K0xqazJfalSooXyWYSiuvydNStKN957yeca/5jgirk=;
        b=QGJ3gxBqRhAefixF4AZVp9uqty2g32MIC7A6Lh48gqph7N7pvW3eqWMlo+y46uwWZi
         bcLFIiL7Dbs3YI/j8z5gb5esw5R/WRbK29R1dEEIs5YhhZcFEwv7fW4fzHJlTJ0h0voq
         Fu129WlRIfCSrC5qj7JFstH8vpZfwm59kAbYHV9m3twUhGhw9prSlN+mfAk2BHJx5NvJ
         RVaqpkX8AF28Xf0otVveIPPNYpjQviJxqXrqhNegKDpOH8OBAx4OHod/OA+aK/dd/5iQ
         xHSD6KpYAsM1Bv6j2UPKu3A50bIS2LDsa8IG5DD09ZQLFsKh9taYZLQw7cJd4e4TPbg3
         es8g==
X-Gm-Message-State: AOJu0Yx83p66Ja/UPmJyILzsSts6Ty/b0Fn5fDGaA6eLjekKjmKSXv9B
	fZccthszrBx6DmbJI76RJwZ4g3HvgtY=
X-Google-Smtp-Source: AGHT+IF3xRES9G8GGVB1JSZZrdyJgQgv1Kl1XF6d1bJ52GQO77fRAeTttstKe7QtzPqxmMtVGOT1Kg==
X-Received: by 2002:a05:6871:a4c2:b0:1e9:a8f0:d6b6 with SMTP id wb2-20020a056871a4c200b001e9a8f0d6b6mr20299772oab.39.1698934262540;
        Thu, 02 Nov 2023 07:11:02 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e4-20020a056808148400b003a40b3fce01sm546311oiw.10.2023.11.02.07.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:11:02 -0700 (PDT)
Message-ID: <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
Date: Thu, 2 Nov 2023 09:10:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
 <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> I'm fine adding similar handling that I added for packet loss, except always 
> delay rather than only on additional events. But I would like to explore other 
> options in the future.

I guess the question is, does adding LOST BEACON handling actually help or 
you're speculating that it does?  I don't mind if we add this back in with a 
delay, but I'm worried it doesn't actually do anything.  7 beacons lost in a row 
is likely not recoverable territory.

I'm actually surprised the driver doesn't give you any other indications prior 
to the lost beacon event.  I would have expected RSSI or packet loss to manifest 
itself prior?

> 
> I'm not sure how, but being able to detect if the AP responded to 
> nullfunc/probes prior to the kernel blowing away the connection would be great. 
> (like send our own nullfunc frames or something, not really sure...)

Yes, the current implementation of this event in the kernel is pretty useless. 
What we really need is an additional threshold that generates an event out to 
userspace _before_ the kernel starts taking potentially irreversible actions. 
Something like a pre-beacon-loss event that gets generated when 2-3 beacons are 
lost in a row.

> 
> Its taking IWD about 4-5 seconds to reconnect, 3 seconds are the quick scan and 
> ~1-2 seconds for DHCP. (I need to look at why the quick scan is taking that 

That's awful.  How many frequencies are you generating?  Even a full scan should 
be ~1-2 seconds at most.  And 1-2 seconds for DHCP also seems fishy.  I've 
tested our implementation to be sub-300ms or so.

> long, that seems like something isn't right). So if its at all possible to roam 
> that is best, obviously.
> 

Yep.

Regards,
-Denis
