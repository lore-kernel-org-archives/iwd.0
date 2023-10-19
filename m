Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5481E
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brfz1Kbp"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2f507c03cso350468b6e.2
        for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697684068; x=1698288868; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XlO9AZ/Q+AXSY6AldjtSF/mpLcYBUc/PD17nxUXTcA=;
        b=Brfz1KbphFHVpeAmtEqI8tVezmgt6aMpTJVrdFbsomLL+/ADvmSo3spECDQTcobwcp
         crSji0Xby91lo7/bXkUyektsS8cq1D6drLHwxm9kn6SR6XiTe+Asuc/rMqB1CpIgctwX
         W9Xn000WH8kEC16cE2s1z/mPohF22M0N55MNz4701tvtFDR0qbHjZX6CcueZCGEMMhke
         OOtemwAxFiIUZwjrxDKmAma7X3iYGevx/UO6SgWuv4rW8bBq/CtpOMc7qY3YCyaG/ncN
         LGuqgTcI9sPC8w7SXtBTN1jmc5kw4lOcbnIAgqxTwS50ctj1NgeeVw6G6zsvOkv2LfW9
         ip5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697684068; x=1698288868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XlO9AZ/Q+AXSY6AldjtSF/mpLcYBUc/PD17nxUXTcA=;
        b=sZtp3ul+64+z3/maG2/+wmRgsAOym4t+wUdtP/Y2bQmlPnR7WaPLQK4Zh4VXt6zIwt
         XC2hk0PQjpxPmYnDWxzIhZUu57QqudZavsh+aqp2dSc3ldIJzff+Vm2m2/H70BhAwOfm
         maaJxlaQyfAsf8WfHjjynDePHkok4aRGjwJkoxhk5vc3xZrQVw4rvU0Vz2nFtMcCG9vK
         fAShtJaJzGI9zzIer/cinJOiLTMUZQg18EGKYgKLleaNZxxGu9LuIfzej8XEiR+lx1Ex
         BlSm5JwruE/x8kDXQNh3bk5hJ4sxzPFgSbVdAPovlu0OBzDlBZ9ZZIQYTzosTCR+g8vM
         XYTw==
X-Gm-Message-State: AOJu0Yyr0nMsEoT6rdhqcwZ9pkdGN1axS/hTxaxrMOALjZPIGhUHo1Pi
	/A2Q/aTC8reW69Qzlo6uAq8=
X-Google-Smtp-Source: AGHT+IERlx/6hK9eWVwz7yJ0/25+I+H2b92tkZmsGtrvPI+sdX/WLkpDzWip+xgtc7davq5MW1nYwQ==
X-Received: by 2002:a05:6808:1306:b0:3a9:ea90:5901 with SMTP id y6-20020a056808130600b003a9ea905901mr1076038oiv.56.1697684068194;
        Wed, 18 Oct 2023 19:54:28 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fa5-20020a0568082a4500b003af5d7d9f3bsm923056oib.4.2023.10.18.19.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 19:54:27 -0700 (PDT)
Message-ID: <c29ea330-c84a-41a7-b5e0-ef44993736e2@gmail.com>
Date: Wed, 18 Oct 2023 21:54:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eap-mschapv2: allow using on kernels without CRYPTO_MD4,
 and deprecate
Content-Language: en-US
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: iwd@lists.linux.dev
References: <20231014235445.167620-1-dimitri.ledkov@canonical.com>
 <075d94c6-4ce3-4945-b765-71ad6285dd67@gmail.com>
 <CADWks+bdeDgAZKUs6wbdi3KjDHeONO7LkmjX_-9wT15m91PvPQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADWks+bdeDgAZKUs6wbdi3KjDHeONO7LkmjX_-9wT15m91PvPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dimitri,

> 
> But also how does the outer TLS tunnel help all the way? Remote site
> people sure, but do people enforce using outer TLS tunnels like
> internal inside the office network? As in can employees sniff each
> others traffic and still impersonate each other? Meaning this
> authentication method is still more or less a fig leaf.

The outer TLS tunnel is mandatory for PEAP/TTLS and is very secure, assuming a 
well configured system.  This means that the station (client) side has a CA 
Certificate it can use to validate the AP.  If public CAs are being used, then 
security can be further enhanced by using ServerDomainMask setting.

Think of EAP-PEAP or EAP-TTLS as username/password authentication within HTTPS. 
Its just that EAP-PEAP uses MSCHAPv2(MD4) or EAP-MD5 and EAP-TTLS uses 
MSCHAP(DES)/ MSCHAPv2(MD4), CHAP(MD5), PAP(cleartext).

How the network is configured at the AP is not really our problem.  There are 
ways to separate all clients on the AP from each other via vlans, etc.

>>
>> Yes, exactly.  See above. What this patch accomplishes is breaking EAP-PEAP
>> support in iwd :)
> 
> Booo!
> 
> Ok, I still want to drop md4 from the kernel though. Because the
> number of users that need this is small, and I would rather compile in
> static MD4 implementation in IWD than to carry a kernel config that
> builds and turns it all for all.

Well, you're going to keep coming back and making this argument for DES, MD4, 
MD5, etc.  I don't think it makes sense for iwd to go down that path.  While 
these crypto functions are old and insecure by themselves, they're still being 
used in a secure way.

> 
> It seems in Ubuntu we have never had SRU of IWD yet, and we build
> multiple kernels every two weeks, meaning on that basis alone
> compiling MD4 in IWD versus kernels will save energy costs.

Wasn't Ubuntu going to switch to iwd at some point?

Regards,
-Denis
