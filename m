Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B142D60B
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063802; cv=none; b=KKESlzkmeOFADKpweJW5z2+BEe30FNrNb/ymdfcr0YonR1twA2jnpxCmCocXLkKaJTdl9HVGbWtc+unbEUZec2Pg8xhBdnwBfBDSWIkRHRHZaQmF9rE1tEvz2ilUUa10jjNeVN3DigCkS/tLbkQUdxUg1MjBZ7NBzL/wNHx5LQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063802; c=relaxed/simple;
	bh=Cod2Bn6KAq+s7UWftdXQsJ1eLr4YJxEZOXRu0VXs49g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cp1q3MStwiuU5ojhF27B7iu+DpKQZ44zcWs+XsRnC4udfo1XH8nqcWsOLi+vn4RvNBxFcF7IcJ4Ygq1JwESLm6iOMd6mn/rEPe5qSuTciRd2+PCerLwBSjFVZBFUHKGOA00VGIJXM5n+Fcy5Z5wMewoX7pM91ZC/Y+7oxz0ANVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPuXzaux; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPuXzaux"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e432514155so2382207a34.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709063800; x=1709668600; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1nYmsNUZ4j79lSU31iklov8YRZ+3YdN1IMNaVqDwe8=;
        b=MPuXzauxKHAwazssGWf3tD4JNP303EhgbbKYGGIIRIhknMFeJ1faFAR6ekJooRRA6P
         QGmzK4SE3V0YMAdOJlrxSKn3AGM3zIoyFe7DEF+CElL/99wtS71xfbGSTwD6MSbLA2yL
         5nPp02EuuyB2XBypEB29L65/7ujAisCLhurSeVMt+tlip4HqapyY3xb/ViM0gTh+UHcW
         UOLXC+omiQyve8tbI5cHpjcMcMxR7P5Soj5fk4pcUu5RdxFVyoP9wQ6337hrfHPmVFwU
         Ulth57Cpwy0BOyMr6Gmf0zV2iGkCBteCtDDDjzS5VKIHVpj92AQY//JY85BpDNPU4S+a
         vb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709063800; x=1709668600;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1nYmsNUZ4j79lSU31iklov8YRZ+3YdN1IMNaVqDwe8=;
        b=O073LdPFbKVx1mCJxzyOPNxw84CRx9ZfwVZIV3HZAo/dv2UtJROYhEyTnV6QmORuY9
         K1Ov5QOpEju6rnV47b61vwZLE6nPGyB2v5M+e32qGxXXidC1aCpb0w0XJ3O2Ujxms0VR
         hUzcFY2xSXBeLY9tzIMk6pqNmUI5NEBJGdk9AofeDn6XDh+/Ff+4JZ7Qs+pJEInszbsQ
         uW0glnBfYSPCeDNN1+w9Pa8quGCnJbF9htaeYJ1I86sMnltqenhpBNM6lLHFHnpaB2wa
         6HYFML+2ooO6uc/H/d2fLd/YhelACO5iIqb4hsVJ4FEoVyqKUTTVXBYf+Nzes+/BMh87
         NZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVqx8n6+GbCyTtKE9HiWZ53s39eO1QqiETfHquYp0MjXk67eiOYb2m/6P1Z0IRGDXNVmlT993Wd7CxldoTXzG3zF7pe
X-Gm-Message-State: AOJu0Yy136Hn4DCACkQnhXn+HDjoTYg3U5VnDkq8Ls2a0koAx+2b6xWp
	ac7kFI1WI4sfCcHxyEur1Cd0G29OGJo0vQoZLCbIHl71q9i8eFMS
X-Google-Smtp-Source: AGHT+IGLF+qvSEn5cDg1Mz0WCkTkmJ5gvwpF4CkDuDpWohrMlmEXSrrK/o7uZSAhQP5yzEvjaZ7kHA==
X-Received: by 2002:a05:6830:160d:b0:6e4:8147:a018 with SMTP id g13-20020a056830160d00b006e48147a018mr11201810otr.2.1709063799960;
        Tue, 27 Feb 2024 11:56:39 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u24-20020a056830119800b006e484595ffcsm1626771otq.34.2024.02.27.11.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:56:39 -0800 (PST)
Message-ID: <c292fa69-6934-416e-9f6a-655b923f80ba@gmail.com>
Date: Tue, 27 Feb 2024 13:56:38 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] doc: Document UseDefaultEccGroup
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240227183405.257206-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/27/24 12:33, James Prestwood wrote:
> ---
>   src/iwd.network.rst | 7 +++++++
>   1 file changed, 7 insertions(+)

All applied, thanks.

Regards,
-Denis

