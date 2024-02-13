Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2C61685
	for <iwd@lists.linux.dev>; Tue, 13 Feb 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865264; cv=none; b=WRtIRKtmza2ZMFNP/hglk1daWBrvsTlXYXIRsJfMqZ1r2vIbEkDM4Hw6wVbUpEdbXDQGvvglJNj1KxyvVg8Thuo6sHkkV5gqxu3i6BoTInWYKQpCdyQiZaVf1Zg873c5KBn2yU6HV7p6PduoGt02XEt/H2ZwcbKS6R2k5ub4tc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865264; c=relaxed/simple;
	bh=zd7VudMnF2Hk2OJss83LHir4SEtWMWmSCZW0MAD1cG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VU9vbHdSyO7taowt/DD5TiWkiVPt9Y5ovOVd5yyJG2WWyKX4CcXs57JsXTGui+ZDSzF56+gZIn7f+D8QUdsnDOMWYYDXvJOXyFWk5lRwMKY+cPT8GWTHPAM5os7Rul8bUiq4mJuM9eC4Ch0rj3gQlPvBzyP9mf+QTp8mqZw+ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar+FV52m; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar+FV52m"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c0485fc8b8so623715b6e.3
        for <iwd@lists.linux.dev>; Tue, 13 Feb 2024 15:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707865262; x=1708470062; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrFmkeVzwXdHDHyIFh7Qbdj/Mhn+pvLb15rbFGRb514=;
        b=Ar+FV52mAml4TUYrADHP5IxoA7ZM6nJWvdJ2kAsRu7TYqRpjftmH2zScFgjhsAfVlo
         mH/iApACY/AjTiQfQuw+cqDCsETeZSAkSYspKZa7SZA1zvIvJtGKG1tXu88PfcV5Zxfz
         X/qRk12OC+v3niSZspjbGKGAz5zLEM9nViAKsO6lwCuKB7h9G6eing014W96qOQ6SOlz
         t1pXFpTaqyIiBKB6GyZDBfecVESmztHdftXeipb2MT6cz2qpT0Ysgg+9z63QoeNPxQW6
         CCX20UPpdaMkF5zh6PoBJ9Iv9m+EcbxnLbhXGq78buGltcJACOMH7/CxuuN7khcMyWmE
         fCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865262; x=1708470062;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrFmkeVzwXdHDHyIFh7Qbdj/Mhn+pvLb15rbFGRb514=;
        b=UHMZO0Jet+4R0nHboIOsMYv+Vw/FBoMW2E323lQmnUYePGmBBiibM0cXqF5x+D/rmR
         fJp+Idp80oEWlsE94hf+GrcbLlRHSheyr2Oz193BxM2tUmGyidV9NHSKEfBcqWCLQmkJ
         gKBEtWenpB9aKTLJ6d0vHgo6fYul/f0gTUwXB+6DDTMUWea5MW1iNNirfWXp6M7mg+y0
         3s7Aw2DHbZD6j/F0V7Bd7e8cKYSlVIJ8O1cpm/j/5fCpiJuoJqlmDiMk5z4BvMT7g4M7
         wHdaZA5byYK404FmHpY+J7RFFPHACJO5Mfb/rOG+sUsTOH+q5kd2wvLhNYgv4bmMDrc4
         KEDw==
X-Forwarded-Encrypted: i=1; AJvYcCU26RaagcZpyWlG3VrUJhjrbcZE+d/1z5YW7/bQfzrwq8hRl9iK454KnBJZyi1W3f7dbqVALS2CkdKg7PaOHqmHQSDx
X-Gm-Message-State: AOJu0Yx8KUSYyMOqKbnZdfV2oTuBL8vGNR2qDsJavFU46RhsCSbb3VjY
	yxBgbp75Dd2R/mMYliNm3Y8GbyQ0NYYThhqFnm8foCxGny5ImYbxuqMJak9u
X-Google-Smtp-Source: AGHT+IGVwJBGf+coqsi5YPvjAdZMfewa1cVEw4WoAkmhIkFZ3muASi8AEhILuwgECY3axrywkig6xw==
X-Received: by 2002:a05:6808:199c:b0:3c0:34de:423a with SMTP id bj28-20020a056808199c00b003c034de423amr1055333oib.11.1707865262165;
        Tue, 13 Feb 2024 15:01:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwahNCUVU2evTLtq7c+4M3ee+lJO95VE5SMvDtDpj9iEw5hJpwZmxsNEB2H+c+axFj+E6ESXE/29p1BnKuZkJRYfhK
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ct1-20020a056808360100b003be30a718e3sm603518oib.44.2024.02.13.15.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:01:01 -0800 (PST)
Message-ID: <7b4fe1ee-da96-48bd-b871-a546b117020c@gmail.com>
Date: Tue, 13 Feb 2024 17:01:00 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: use reason code from netdev_deauthenticate_event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240213180902.850693-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240213180902.850693-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/13/24 12:09, James Prestwood wrote:
> The reason code was not being passed to netdev_connect_failed as
> it should have been.
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

