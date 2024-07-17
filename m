Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F0183069
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233936; cv=none; b=CbbpyQcjjp2lgYwA/jLwwn6B/6x7R82bxAtbv1+fGtVAQgCFNaDpSerzUTMDr9W1UxT8bQA/OzrjubkpGH/tszfzoYmU9MsBCtS0oha1zrxoJUU+yBFGPgdav9tzvDdzA9AozH3jI/v+zTVfJcWCoc7dCCoq7WU8KYm9qxgnanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233936; c=relaxed/simple;
	bh=1soYR5wHCMzzPYS+GdIsuSzQRECxYGhLiN/Vhh3467k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=skQ2IwLhoQFCqaUdSG7UQQ0kBHksm32s2kf5Xze4VHaWGjxatjfRPpDQDlzCaN2cHYJfJQRXGY1hAAeCDnrcEli4u55BSGiX4lDQpkw98Yg0LbolZ0gRazGf65xC0Ys12CELL6A85syiOgonzp1Kty02XmgjGzvtYGlRA7MsRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5IG3hiC; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5IG3hiC"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260209df55dso2825690fac.2
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233934; x=1721838734; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pkYOwDsxA4tdzSYpuCJBdzuN8ZUMnLNE1KJ70ZeAMA=;
        b=E5IG3hiCEF7zZYOmVecYC5TIlQSZUoQUsDeQrm1NII/8+T46GVFUt/xoy/+aUm0+40
         HFOTJ03dCZLhMfNkUffWcHJo+cJgAQ/w+wv2Oa4LsiajVO+oJW15XbSjz12Kno2rwRSp
         +ry5hCUZlNA1SMWAGdQZHuStv+DOYNntQ3n71nbMLLIRryUM+m8x2OKv8umgR00aHWtT
         RSB0sYrVU5gKaZxkUOsDdAfkfy3W7ecIqr5gaO0VCwdiSEndjlUQvtchnHEDnflBoIkc
         a8hKO9kUXSMuZIy3st3RXnQXE43ifG7t3uaOBoE7YSfEGkBnPEX8jiDCdpZCLrPVKr0Y
         w5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233934; x=1721838734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pkYOwDsxA4tdzSYpuCJBdzuN8ZUMnLNE1KJ70ZeAMA=;
        b=OGhXEQhl8Ns5o8U7h5TJh8vXCJMhg+NmmLUSkUtA7I6yzYpjnVnwEoY7kVvQZ+pwXG
         f2JUSmBs3ZxrKdNZVnz8UWLerwCZ91sfuOndcu4eMwRnPVBF++6S/Oka/uo/CT+hHmP8
         +KmTlsBqZu+/AnQJJvVmF7tJpzSFV5GuxPauXRAyjrtZwNvBGuWut/M55iTEtQrRG3aK
         EbC/eITqbQJ2sU282fPhDsL5KPXYeJ1BGPkJT8QYTguqteBvV8ZORduXXbTM9OIh1zRi
         p6rbudDU2Zshwo6tlm0j7Y7en6a9vZaKRzYUPGXR8yU7XuNx5I3iOznlq+Xs1rvrvno2
         6dkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7wDAeDtrKwJtY4yYJV5TB6rYR8pMw2vYHxqITGV2fp+uGVOCZePccJqIAtDt+5KRPDFPCyjHLH3TW9LCNNgSrTs/t
X-Gm-Message-State: AOJu0Yx7Sv/8AO+fuLilLPbL9vDn+eWmjwRbsqUvl5Jia3QXL20WBfPw
	ouu2SaLQNJQ622n01tl1RiemD+XO6J1qblAZzfu+ZEM1ACqrFCzQ
X-Google-Smtp-Source: AGHT+IELWzjHRg/5/hIrjxvI8WNcCk8r+PRS6WTawPwYJ4JufD2pmI/y3RR2PXqHYiD/ZTO8s43kkQ==
X-Received: by 2002:a05:6870:d629:b0:25d:ff4c:bc5f with SMTP id 586e51a60fabf-260d9204199mr1830442fac.29.1721233934006;
        Wed, 17 Jul 2024 09:32:14 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-708e78fe0a6sm127456a34.66.2024.07.17.09.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 09:32:13 -0700 (PDT)
Message-ID: <c366adfa-7c66-4c4a-a8ea-adb40015b0cb@gmail.com>
Date: Wed, 17 Jul 2024 11:32:12 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] eapol: move HANDSHAKE_STARTED_EVENT to eapol_start()
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240717145525.2656306-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240717145525.2656306-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/17/24 9:55 AM, James Prestwood wrote:
> This even is not used anywhere and can be leveraged in autotesting.

'even' -> 'event'?

> Move the event to eapol_start() so it gets called unconditionally
> when the 4-way handshake is started.
> ---
>   src/eapol.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Regards,
-Denis

