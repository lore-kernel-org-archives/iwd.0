Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075147F4D
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6ykhJM2"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b9b90f8708so131022b6e.2
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701891848; x=1702496648; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAN/6kX7WFArbprtyVd5M5+KOkOVCaPQ9nGwcnAP5vE=;
        b=Z6ykhJM2sxfvJYNyhiIwv3afeTaglGg9vqvQcYx+BDc5ET+KvV4GP4/K2Q06zkqUSK
         OVWtRig7fdNW5qpOxhnXOocRJJ5aRuLpPqfmU/XYHGJ7pEYpdKxl1sY/ZoGzTjMg/OXt
         4f/rsFK+E5hwROM02t0qkK6FDOMhlBX8+SnpRZm5yli89hoN1wUs+4/2ZpAgHWpbRunJ
         AWBfub+sgSgsQtGxKqX0lqodJss6lMvRgyuaYjZCYxDBNTB18B060W7zGigHhDB2239S
         ETSNL1ONWwNYU995iBgtFl8gGX7xpAQ59ZXKq+X2L5a2GjSy/MKw6xPYHhxMVmlh6uNg
         KjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891848; x=1702496648;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAN/6kX7WFArbprtyVd5M5+KOkOVCaPQ9nGwcnAP5vE=;
        b=I9I8n/lAtQN0xCk5xKYbAiOcMwbJatzhf3gsEci8Eh1M6LUxrxcno6Oz4phHP6HP1O
         byNAeMCu0ukgu3rzjkoXBEBhKHGzJuxsixQMWtHdmc94bpiaxjKfCd/mGusFX2VEOqH1
         YHn5P0fKMLB7KlNxoCdEhJDpSYUjTGdC79r/ACBHjwxbvyBRW0PA+Idn37bsqPxUjG4i
         ICsyR9FO7vhXN4ssbHH6MsBJtUlItg9okLfdEAnOgfUlMZuobZgl5CxUgmSEJd1BA/9f
         rKbonLoJgJQR9lLCcuWyuLTuT7SZK/VkyWKaIh11CX7BPWFRM530APS66nEBcW4q/OhY
         8cUQ==
X-Gm-Message-State: AOJu0YxeemZYA+B8/Z+fPGTw99Q78A/HggLea3hPxxq7XKNNZ/xvMImO
	nzdI3YZXgOF7J9nT008s31A=
X-Google-Smtp-Source: AGHT+IEoUeBJm3fREv5O84b9YnDShjXxXA4x/V3yECAZL0y/fT7QnygpssPoIAwteNERM16zLgIM9Q==
X-Received: by 2002:a05:6871:e492:b0:1fb:75a:77a0 with SMTP id pz18-20020a056871e49200b001fb075a77a0mr1676411oac.81.1701891848422;
        Wed, 06 Dec 2023 11:44:08 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id mj5-20020a0568700d8500b001faef8bb534sm114258oab.22.2023.12.06.11.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:44:07 -0800 (PST)
Message-ID: <69055eff-521d-4e2d-b3c9-c98bb7ba36fb@gmail.com>
Date: Wed, 6 Dec 2023 13:44:06 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] network: add support for SAE password identifiers
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231205154647.1778389-1-prestwoj@gmail.com>
 <20231205154647.1778389-4-prestwoj@gmail.com>
 <03c0874e-0f64-493f-b9c8-cb302045938c@gmail.com>
 <6faf5c3d-cb78-47c0-a3d2-aec8211e79cc@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6faf5c3d-cb78-47c0-a3d2-aec8211e79cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>> Loading the PSK will fail if there is no password identifier set
>>> and the BSS sets the "exclusive" bit. If a password identifier is
>>
>> I'm not so sure about this.  The trouble is that this logic is sufficient for 
>> the initial connection, but isn't sufficient when you consider re-association.
> Your right, roaming would be entirely broken between BSS's that mismatch using 
> password identifiers. Maybe even hunt-and-peck and H2E? not entirely sure. We 

Well, ReAssociate would just use SAE passphrase directly, so it would work in 
theory...  But it is a bit of a strange case.

> would need to re-derive the point for each roam, like in 
> network_set_handshake_secrets_psk().

??  You mean SAE-H2E with password identifier for BSSes that report 
exclusive/in-use bit and SAE-H2E for BSSes without?  Or something else?

>>
>> This likely needs to be taken into consideration much later, when building the 
>> actual handshake state.
> 
> Yeah, we'd need to move this into network_set_handshake_secrets_psk and rederive 
> the points. And actually if we do this storing the points in the network profile 
> doesn't make a whole lot of sense anymore since its being rederived every time.

I would hate for this to be the outcome.  Re-deriving the PT is pretty expensive.

> 
> Alternatively we just keep it how I have it and tell they user they're network 
> isn't configured properly :)

I think it could be argued that if PasswordIdentifier is set, then any BSSes 
that are not H2E/do not set the in-use bit are not connectable.

Regards,
-Denis
