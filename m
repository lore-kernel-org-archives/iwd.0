Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF14C8F
	for <iwd@lists.linux.dev>; Thu, 10 Apr 2025 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744256144; cv=none; b=a0bB+dPaj/4HFOaLs1eNvUy4i1nTjxzy1t/fFNn25p4UcwFjs5kbgU4gVhwzGe/VrT3aqsg3qebXLkjkhkgFehsNioRIEugQp+6GGh/dWfythFZQIk9FwRb+AAhMSM/tTuKgs0ZwN4AOu0K9446uavwNiCcRwnYJfSduyi1265E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744256144; c=relaxed/simple;
	bh=ZFtwyd9qBpXSc6p9bnnAiSCCG2cSaW3lj5nol+ihOlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGomnGraJXhtuPK8LEWHnDdhmGGbZW818im2YxOXneipfDND4okY4B+HDqD5inyi6lRaM0stD4K9ZLlN3syr1fF181b5tYNhjScggC/VveuoMlc2IsQas8F9f/GHj9810ptjey/eh9uq8yyiZf0vaszmnkuUxhSGF02Ld15aqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asbsxkzn; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asbsxkzn"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c12b7af278so297840fac.0
        for <iwd@lists.linux.dev>; Wed, 09 Apr 2025 20:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744256142; x=1744860942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CcRgAhZC8xR4s0QW0c23MqoaBo9lqb6zC6ylYMwcEM=;
        b=asbsxkznmz4BBWrr2yHi89MuBLli4peFDavk8Eo8w/80ngyC6HELdQzLgjf2k3DVUg
         HLtYxf3TLfs0fWhs6rJb8NY0DwDBl3nLu/s3l/QRPjIsjkTwH1INvjlnynTsE22mNYW0
         1U3rvKRUeNIEnPf2g1axb+TSJeIL388U28INunqTx24MpEHw9+LLpwZqpN3N1XUPEI/D
         3r6TpBbRhGMzOYkmNCtyoEddpjKpRY8O/mkmLq7rUxMuwMw+iYd1sRTznHGvx7Ncmw3i
         Xz4b07OLbEuvHctqZEhbCo6btptCj2NOiFE9rHVHbBEJpV7IW9hzNI4alt+RkmH9wlKG
         7ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744256142; x=1744860942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CcRgAhZC8xR4s0QW0c23MqoaBo9lqb6zC6ylYMwcEM=;
        b=AImyI34cQ5DpaNW4r70dlQPmtYd8zwAcO1BItlAYwunsp063qSx6AlewK8U9liHDvd
         zdNxjEHKLt4H8nNFpMHj5wjDVHeMvc4w7sNDaXTuS/TUSuhdOhTIHfnEsFL1hgWa/437
         YvtwjAxX7yVSB3UpkUM5sRqARW2OLy1+VCValwBDrSZP1qK7mjzcWk+aQihc2979HUp+
         I9wi7qakdzS6NjTyfiqx8CFZgpKiCEqk1y4OFinNw731TXPtB110RV+nREmYw83nw/z3
         NAiU+wk9xJXfJ1A9OQY7arkOKrVBTEzZ/eTDruhCLPIGHyisuiMq9jBiq/JoUP68iqK1
         0aCg==
X-Gm-Message-State: AOJu0YzNVWW7RwqEWVrotuHK4U3oSJ0tj2wRqF4b+lC8n36hUhFP5xkL
	uLUkvnRuGrUyeUn80KxC++5qlTLs9iBvQN9R9DMVSeEeP0Sib6xV
X-Gm-Gg: ASbGncsIps9ZGfm7Je9WN5Xn3MZncqbfadagBglZPubDylMBE95iRFzLGprBTCOlTul
	F59ldvbKUF4b2RIfAube5U4/NfVHq1ywZpQFNLWEYQZf5AjhH+iv8WZ451D5Uk9gjOzqFqVxmbO
	sGM3k0BVEnnjJgd1Dzun6kbqfiAw3P1BN/Vc+7BN2DGYy7ou7KvZ2VayoXVHInYKDNCT6/yQMMo
	hdPt2nINWDLCN3wNAuOpNDjkwys6aY/m3YffpmmJcanKgAyJhnMWZ0Cwh4jC/xWiFbx4n1ca+lW
	3OeEKSST3TcVDugUf48cJYEVqK8n38sKQi7lh38U2GEuTFAB74TmzvzzRFJoSOjyR2HAKTuGPNM
	6S0XzrQ==
X-Google-Smtp-Source: AGHT+IHQsN/b6MLMSSrxbvEhM2Pidan5PVUOZLJr4SuBG7ZoYbEF9QwudwehyQUZNdKfCPyDQG9dCA==
X-Received: by 2002:a05:6871:3a85:b0:2b7:f6c5:3c78 with SMTP id 586e51a60fabf-2d0b39c654amr641588fac.8.1744256142415;
        Wed, 09 Apr 2025 20:35:42 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2d096d54927sm516649fac.50.2025.04.09.20.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 20:35:42 -0700 (PDT)
Message-ID: <9c8827f4-6889-481c-9e50-324fdde3714d@gmail.com>
Date: Wed, 9 Apr 2025 22:35:40 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: strange behavior with synthetic ap0
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
 <f436a083-5e70-46f3-841d-c59c10c6adf0@gmail.com>
 <CAG17S_N=DnnnLY+hGiqQCfopr1ZngCW0T4_H0+yyP9Z8DiqzhQ@mail.gmail.com>
 <27237ccf-edbe-4a1f-a39c-6070e4a7e821@gmail.com>
 <CAG17S_NmCR--cBGMmjRB5VmEcuJyKqqriktbzo_Z4eHGXg8TdQ@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_NmCR--cBGMmjRB5VmEcuJyKqqriktbzo_Z4eHGXg8TdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

 >
> With the current version, I get this:
> 
> root@pi4(rw):~# iw phy | grep -3 'interface combinations'
>           * crit_protocol_stop
>           * update_connect_params
>      software interface modes (can always be added):
>      valid interface combinations:
>           * #{ managed } <= 2, #{ P2P-device } <= 1, #{ P2P-client,
> P2P-GO } <= 1,
>             total <= 3, #channels <= 2

It says 2 channels, but most likely these need to be in separate bands.  You 
could try running AP on say 2.4G and STA on 5G (or vice-versa).  See if the 
disconnects disappear.

>           * #{ managed } <= 1, #{ AP } <= 1, #{ P2P-client } <= 1, #{
> P2P-device } <= 1,

Regards,
-Denis
