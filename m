Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25528DCC
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 16:47:18 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57d086365f7so1678059eaf.0
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695833237; x=1696438037; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuPN8xbig/g6vSupAJvwt/qpdw2p+8bW4HVVjexjyhM=;
        b=EPf3TDiPmQi5GMsTJkgVFDUSajBBQCZvdsKF2tGyYaIhcquYo9EL+DOjHnq6YpEwbJ
         ppTueOv0XOfsU9LdmbhjlcFm3LH4dRu+AkRIPz9dchloDJjU9E7YdNCDzo+9IS9QTnNU
         KYWslKIiXXgAGE2hVQkZhwQlispW9i31K+I3amRpk3HUQmcWZp4xd3nzz8bomVe6ssqf
         Mv56qi5QadlpXKJzhL3CqOs0xEEHFxCcyRYIA/wFeM0IhFNOqd8ZAqpHuy+2cqm/+S63
         ef1TGojFF1M3v4l80pb0MvI0ZjcSq6FLfEu9NiO3nGCvNzdOvrm65bWnw0QpQ1hItz6Q
         CqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833237; x=1696438037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuPN8xbig/g6vSupAJvwt/qpdw2p+8bW4HVVjexjyhM=;
        b=MXKvbS0XOxS5j6f0lj9BZqB0YtItjlNY7Sws+wZ4NpUsdE+8dKASYop8AgNdmD2cGB
         iCK+CdANTq1YEhAMuNmZeFx28G7A2cdXtA5xvR5JddvCak0AYbmGUM6jdpRdOe5p+Dr1
         I4FvPpHUk9UBpWWlEWkK7WWFDafqD4doJmzxTXutqgq3efv0U098uybJthl+xPy1NiNA
         1k5vKZZOkOFxSyDyjjX2EaCKlc6Dudc1HHZqwVJgcWZg+wMLq6gpHggsiGAtSO99qKzw
         vbcFk90PPQCLLXwtKJmXwfL+3j+Uh/TGQTdX5wJJUQ2DqTIpKIOm0ELp/W3816iq+d7m
         Ct7w==
X-Gm-Message-State: AOJu0YzLKnp19hTUKq1vWADGrL3CA2EpZeyWAIFmfQjScCylpZdU9nY+
	bimhSAYDu/pfFPlYZ1BHJK6IDU6vcYM=
X-Google-Smtp-Source: AGHT+IHFm/2o8787hgRNtym+WUX2KK4vYPbsIqhLwN/RHOnkfyWYH8QJBOSIC4kA4u67EP1AHl1fXg==
X-Received: by 2002:a4a:761d:0:b0:57d:e76d:c206 with SMTP id t29-20020a4a761d000000b0057de76dc206mr3028805ooc.1.1695833237476;
        Wed, 27 Sep 2023 09:47:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s124-20020a4a5182000000b00573f5173a57sm2815066ooa.23.2023.09.27.09.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:47:16 -0700 (PDT)
Message-ID: <ccaa868f-d803-24e8-733e-91c6d6d3b282@gmail.com>
Date: Wed, 27 Sep 2023 11:47:15 -0500
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
To: James Prestwood <prestwoj@gmail.com>,
 Bryce Johnson <bryce@redpinelabs.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
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
 <98464440-5567-40e7-aa26-504d9c474b53@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <98464440-5567-40e7-aa26-504d9c474b53@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> I believe yes, it can skip SAE entirely using Open Authentication:
> 
> 12.6.10.3
> "If a STA in an infrastructure BSS has determined it has a valid PMKSA with an 
> AP to which it is about to (re)associate, it performs Open System authentication 
> to the AP"
> 
> So in that regard its faster, your saving 2 messages essentially (since open 
> auth still requires a request/reply).

My memory is fuzzy here now.  Aren't we skipping Authenticate frames and go 
straight to Reassociate?  Or is the kernel still sending an Authenticate frame 
as a result of netdev_reassociate?

> 
> But this all gets beat by FT anyways since you can skip the 4-way handshake. I 
> think this was all considered when we decided whether or not to implement PMKSA, 
> it just didn't seem worth it since FT exists and is superior.
> 

Agreed, but WPA3-Personal is less likely to support FT.  Also this is 
potentially beneficial for non-roaming scenarios.  I.e. just reconnect after 
sleep, etc.

Regards,
-Denis
