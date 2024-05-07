Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E216D9CF
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097865; cv=none; b=VsRIDN1SeXz/td6GDVAx5pXe5o0guUGK54rVYCkxHXYmBTBOsgZcS9JENQpNsfIAAWQTomeiNmr7IrDgeKQq9i7bjhzm3tl9dA7S/KqUpfco1Yy+iaF6KL3GCaxMoHjYeV++myJbG0jRNfdiACRE94uIwF1UIoBtSlvLWDMkdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097865; c=relaxed/simple;
	bh=sZgmndQhkymnI7qVygGAHk6qOVuMDi3hbpSpYHakAco=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OnZY4xLqeGSZZgGqnIJ/s/JIYV1NMVfvY6FNP5u5TTl+85vqMDcH9IqmSqb6hiSAcLftFTkJ7xLwF36q+bGDSx7HU6RT0Ww5OUTMndK94vAl8A1e/90VZFnAR5MSjFqPQ1KR8fa0wIQXgVYIbHyh4ihA78mGW1DyQnd9NCn0iVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/+akQPP; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/+akQPP"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23f2996b634so1818684fac.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715097863; x=1715702663; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMbH/5xaWNUFAiYy2lXhlYzSukyqUvKvVUUzf967pHc=;
        b=T/+akQPPz2oAO33gu7gZX5/MlTtIP67/zaEkDSW9JBfGQOPXVki0r66bS2xWQ/MlCY
         zHm82NrP0beeCPe6703zrbBC7gILWszcyIb/qQYq/TzjEqMusPrXXuhT3FVuIJvGvwRI
         tHcsxzlx3pA8jhfQbgSGPcBNrzHMnwJck1RHZfaLdtF7FnttQNhrdObeQlE+x+dBH1xZ
         91PV89F7DT0QzP6HfctBExn+VeXkdk8nIAW2u4F5xMWsjkqD2cYmPpktn6Wlf4dcEIn0
         rqU8MkLw0l2N7C+HqNF0IC+MVV/LHjeU70D2Uq8B17qeee3TJ3s7nUoQ0I13O6rSNeb4
         PWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097863; x=1715702663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMbH/5xaWNUFAiYy2lXhlYzSukyqUvKvVUUzf967pHc=;
        b=enDfS3C1JCt9+pbaMiwpgwrQSRYKWkoZvhL8w+GRjxtpcHvWe2pzICT2oTOJUdI7zH
         o5pIMkgjp7BvD4oKqc8X0IPO42+XKrW+fp56Wtp3mx8Bii4r9fmMa4IdxtVaOxJyZU/4
         iWS54TO9RsiuYxQqvLDsj98IpNvAzBGBZpaO9Xp3sN92P1hMuyWgGDqG6Yxno5WXxYVz
         2SYo5+8bBftahI6LA4nBPuaU1MXfAzBh4rK2KdJru87x3F7lsSCEYZ4KPSQ/oryAb0Zj
         r0lSq4vf7qinOCzDCA4pBVVqXwLuSUxWuHhJTdEnhtDbEjonVWo9XPBn+4ugO98NTS5Q
         dBvg==
X-Forwarded-Encrypted: i=1; AJvYcCXD7kmZlLYdpLgR07bZAmXk6oDXm0ZMv7sCItHfTIk5dY6Y1WqWKv/cLuRgjtAugboIrHpiu4+4DSZnabPf91I8ebFT
X-Gm-Message-State: AOJu0Yxe3PwfwYZEZnX1Av+ecn9AA8F82YcLOCpAt1fW9XLKPuKXHDjm
	rOcdp+WWzJw5zqQ/Vj8xHpprwQHZkmBE0BX2X0MVCqcQfZ7VKv+6
X-Google-Smtp-Source: AGHT+IHB6jVNhNccAvhejMxUElVZVagjxtO+UcEf1a6wAPFnKcEm+1hRCycju2LHX+Ebo5VBmD+lFA==
X-Received: by 2002:a05:6870:701e:b0:239:52f9:7f15 with SMTP id 586e51a60fabf-24097e79a5dmr22060fac.26.1715097863234;
        Tue, 07 May 2024 09:04:23 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id gz12-20020a056870280c00b002376b807200sm2601999oab.5.2024.05.07.09.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:04:23 -0700 (PDT)
Message-ID: <0cc7a0c5-c6a0-4248-9a68-c247451f41bc@gmail.com>
Date: Tue, 7 May 2024 11:04:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] eapol: encrypt key data for AKM-defined ciphers
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-13-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-13-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> Support encrypting key data when the cipher is AKM-defined. This is
> needed to support SAE in AP mode.
> ---
>   src/eapol.c | 51 ++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 36 insertions(+), 15 deletions(-)
> 

Applied, after amending some > 80 char lines.

Regards,
-Denis

