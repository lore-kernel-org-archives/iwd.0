Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90B43AB3
	for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mogcp9PD"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2d9ac9926so388446b6e.2
        for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556758; x=1698161558; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMs0IKRt04EShr1xtgrWevIrBWkJahSq8IIvATq9fmk=;
        b=mogcp9PDNinlPjV1WQ0eAFApqQPj3G9QC2BRUC2k9DNKpiyoLHcPR6VNdTPgq1ERSu
         wxyVXZJ2gT758GiTpUTU0x++AZYehtWo188Eu/uUxzcyXAjGHK4sOMBsGosk0LkVw1Ik
         VR2+OMtqu5/Twt/24n/jM0BWB+SHpJBiSwzoAZVHExUg3ao6SgKY/hwjRi4Sho/npF6o
         e/iGxYsw0dQD4Yv8Q2JB9JJp34HczhwiGVewV/m/Z95w2nbAQOU7vIU9Fl3Pse0aRmjQ
         q+H9quZ61XyRt94TS9vMNlYKqPMkTkdEtsXndGUipxP72vSEWJNYg/8Ke0KPu1J1uWda
         tuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556758; x=1698161558;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMs0IKRt04EShr1xtgrWevIrBWkJahSq8IIvATq9fmk=;
        b=YcoUt7PnI8dGMq0TTQKjcOUNXLHP9IGGCPMqo+FUew2gAz19lyhcnD9KCeaKtYI0fe
         1hyjcHlk0Ns38uBfrNKXAfm/H/854ydrRi/BQRquJajfk1XAkZjH3CYEn08EpFQ2TtnA
         Qtg2nn2Gq2T2nbsys6Xm26cNtWTPj7rW+yj8J8sBCtTTsGARVlwMDsnbHenx0ciZuljh
         4qMprgFbUbaDQk9H+nAuazyeO9nCMZca5EqIxCuHUSRBx8UtwBq41LHBsBqTjWGKF9FQ
         q2uN1MLrne8+lomR+FXjrfaMVvmyc7oDhNbWLwIlGR08JWODJtcjB2yjXZnw8+9S4bis
         O3aw==
X-Gm-Message-State: AOJu0Yy2FM0FecGErEB+hP3ZZdVp3rFjIr89pRu+HOtxSdSNeZuQG6c8
	+y8Mc0HGOz50Ye4PnXOXGaSKCbECjTs=
X-Google-Smtp-Source: AGHT+IFkGCcJHGP0dIbwFNol2EBQTBGHcTNbDDkiRYVTn+iI10ZKooDP3HnhiSpiIb4/9bEdU2T6mA==
X-Received: by 2002:a05:6808:130f:b0:3ad:fc0f:e852 with SMTP id y15-20020a056808130f00b003adfc0fe852mr3527225oiv.23.1697556758333;
        Tue, 17 Oct 2023 08:32:38 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z21-20020a056808049500b003ae11a7ab80sm292394oid.47.2023.10.17.08.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:32:37 -0700 (PDT)
Message-ID: <936c5cc6-b1b6-4650-9a26-e7dc4ecd0c2d@gmail.com>
Date: Tue, 17 Oct 2023 10:32:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] dpp: move/store max_roc setting into dpp_create
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-6-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-6-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> This value won't change since its per-phy so initialize it
> when creating the DPP state machine rather than every time
> DPP is started.
> ---
>   src/dpp.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

