Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EC155A55
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097165; cv=none; b=dEQaqca4V8aF1DkQKfNqPoQepWnkTf+QE4A996jFRJkRBWHO39hGzJ1lg4RXmNMtOQt7uMQX+k5RcNQ0+UwnffxGbMiGMVnAj4J1lhrJc0uPlbugkpRNBlrFk2gkpePmLa2MxGV+a9dt0/XJf9YnO+IyYEv/lhG8mmC/rlGNcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097165; c=relaxed/simple;
	bh=8VTw9xwdup9xTSLwlkyd/9fmEHWHSqZVSR+qPqlbLHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C7/NK0Bvrj6EYR1Ld8JjRCuBIqjWvlkg2RPBQ7IHgNZ5fWWHEV6HEtsE0/9WKG79JbZc6X2hyxqbZOkQ5zq8YYMbSbJ0G1IGD0Zz/ZL6cLwJcEiePN27prJj4jUHdyK3OjhgZyDLjpNNoB43306hBBfPiGtowKQoIElUntTUQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGFMIsUy; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGFMIsUy"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23f55e2e908so1397166fac.3
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715097163; x=1715701963; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moByYiiJaQkMjCwJgWb5Iw2kz/IxVaEqP6Nb3Fzcpmg=;
        b=DGFMIsUy4nWHh/LvplxJXtb22XGgKje9UaNG3IM0zzW+yjkzBCUq3P8H/3j825ZfxF
         rQLr+bTG7ieDKCh831D4fC9F7sqdyKpxq0GK3KWWBwPMEOA305h3kmFkTTKAmsLyFl1y
         TNtR0DJGRDqRJyhsViqvvV2pW8FSy5UDkTx9/M6KuLSoPaAk15o1U4eAtLy1i2F6PwVR
         aYvoJ9T2ZrpBUOPCUGC399wfyYae0IOg7thYTrYSgdGKIY1+c2LZWtSUOxpKHUd6K19r
         PxDaEq8pePDlkOVW95UMvNQ/Tqmlknwn9pjtV0+cvLdgacIgwYtKMr16hHYg4AiP2/SI
         TFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097163; x=1715701963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moByYiiJaQkMjCwJgWb5Iw2kz/IxVaEqP6Nb3Fzcpmg=;
        b=okBpQeLrCQwYiRQpy2FgWKFi8RJFcHq9sAfxQ6Dunb4ulD3LHI6/3ZP6CWZVBSbDVW
         ubCQeI1Og+z6OnsaRs3Mg2sEIWqi55jzZeCJW3DbYHJ5uwRQ0zKQtFKT/xdY5UqjG3ID
         Z5ShhWdPfgYoPqi2dlUbZktzDUAUKcAM5tV0Mrsf3UB1Rc1G3oZIZSg6LzXDv4xw6SXa
         hllA5dqT1nqzdO6xINBNfIdrpYySQ4bjtAbsA17YU77HZY0TKO25yk5XVr5R1fbe3Wnm
         zjyW6XGh+jF4aEDkb5Jrpni5Cd0ZAK+gSaxxAJ/rBYuAwlyqzD7mCJx0/Dl2TyN/2PF2
         u1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWggNa9OqvJTtdZn9JZNseEt+kRSpsK/gWYDzOOESeTinHTVcvEdzExIbJFSflmUdKg7iEsEgro8nJqUt8aFMO5ojg3
X-Gm-Message-State: AOJu0Yz8ZtMGCBkRaR7R4EHjsbK0Sm24FNVN6Jw97xYlXuVHQUgK/ymz
	TpWOGZSxxJgtcDcye9mJ6wLWIjPLKEk7QEL+WNIlmsUA1CHxrhjdLSC6lA==
X-Google-Smtp-Source: AGHT+IFyDT73LVmb+B3vY+utM9Ap/rBmgIPFir+GON/OsDBKBmeuZK2BUBdwq0s7fzI5cFH+XP5IkQ==
X-Received: by 2002:a05:6871:7988:b0:23c:3c37:a4ef with SMTP id pb8-20020a056871798800b0023c3c37a4efmr16709590oac.29.1715097163473;
        Tue, 07 May 2024 08:52:43 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ek7-20020a056830710700b006eb80dd6c97sm2540364otb.68.2024.05.07.08.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:52:43 -0700 (PDT)
Message-ID: <3576c619-5a10-482f-bede-d029264958a7@gmail.com>
Date: Tue, 7 May 2024 10:52:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] eapol: support PTK derivation with SHA256
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-12-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-12-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> Support PTK derivation in case the negotiated AKM requires SHA256. This
> is needed to support SAE in AP mode.
> ---
>   src/eapol.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

