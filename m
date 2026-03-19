Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDB392C45
	for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942096; cv=none; b=LweUVxvz7U3T1R8tYj+5nlJK1uAOOb5R8MDszLBdnpo4ndkH7zQq1FCUU3QGlm45cUocdnRCNZHmqUK2eGfPPvjnELZm0qfK8LgzDuv/4/JhxjRzyl+w40Nt5zNySRuW9bMY20wfiFZBQ0XyvqmrOA+BCKCb1ITl6RrrZY74Jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942096; c=relaxed/simple;
	bh=6bq0R0EXtdVWq5sS1+OgqMlVNeUMoIXlnxGe5eUIiPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b3Uq1am6bzo4kZ6MOXQVjERKc5UzTvw5eIDi7h8Fy2QWajQliWLDIf90UZQ0uhIeL8GM8hwqXMXX/MgsegNhP7i+CO4pnvGaN2bn/bSnsE7g5dTU91nmNOE487o0HTQepMQzro4cl+p8bwAWUVcX8fR9ViKN1m0+TLKGZsPK1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEbO6uM6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEbO6uM6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad9a9be502so7166555ad.0
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773942093; x=1774546893; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SaLUZ9mql4wEdqvhYm/s9JbBiAf/Wa4yQ9zxQXTvFek=;
        b=AEbO6uM6YVdZJRBUha8QK0soeE3J29XAcjTmWytFO5kZe5IduGImf3ePrtaSIsm5NX
         19eiHNOiwFz8mgNho9zm6Dfmfa2TeILvz+J67SClvSDYa8rUmAruHbb4PE4WtTQiaC9y
         pU1TMYsh05P2kCDc/S/glGIVwi13YWDJU+xlKOBjK4yGgehIP0RI/DUdPlF3XsN2pjsa
         Egzcca02HrY7lf/Qm7qHIEfwADbhv+D40RiBZce7ONPNVsieEm8TpgT0q7kbbwZlvyYc
         ayUINKMYnP0VuQtItAklu+nTba2m1zsRlme5Nmj/VuQfmkAcmglHthAEkbCJxI5fCM/x
         QTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773942093; x=1774546893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaLUZ9mql4wEdqvhYm/s9JbBiAf/Wa4yQ9zxQXTvFek=;
        b=E/JogSTAuvBoA2QEqQn96t1OsJEHM91AhhFMf4AhfODnYLI27X3xcWoyzZKXagZpnc
         t/IXgMcd9ds6e8Zm1/RyJCICOQNAEFvmXUGU4JJDJqYMSufgFcncCoBrWGs9BWNZan/0
         RtNGmULIV3PK2d+4F3EAXihFxbxNuNAxWFT/759d5XLKfA2+vvSolLV3HGtSAm63UxBd
         CAYuldUWhTFgt/+cHOlHPMY2HXX65fNTzdNH5xALvDOaLN8tBzjDMkSRTKa0InST5EIB
         dpHrrNWgppyD8RyXS4ISHqBcfE2jfyLQdXlk5+JgX6sYz4lZceFotUPhnyfjBwaUHun/
         0fsg==
X-Forwarded-Encrypted: i=1; AJvYcCWfOxz/iT4D2yWYTChB1gor9MvSuhUOqKZAgj01R/T2znCntgZ5VQ6jmdZaLwoV/vR/+fM=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu8RedjpC+9uVUcM6L1XHjEg+yZVjojce5MTeQa/umRbqr/fwP
	AiyM7kIVqHw6BxfU/WVdlG5Y9Z994hHInKBeolUvRqnIKdqd+a757Yl8XtGTUA==
X-Gm-Gg: ATEYQzzGgERTRG4HdQw/fDy3th++191eDjlSHeQHaKlDDjDHIiMqSC1WZCcZxM+GQUd
	w+w/IG6hdbJ7PUSM41xrg3/u3XXLZFvFehniK5mm6N69L90PmUnZmTSnBSKcBl7buW2TRIIKLKM
	GMUSZzd8tE2Qy/iAwqe6B/pPB93/R1ppNvlxznKaa3awxKWC5Vl/6zVIT7tENmE/g7522StIeBq
	hK1OE26RtBmUcoBJgBDNvdBS7lEfrY/1vePjxOa+IRa0nTfS1n+lPS7IgNHT7oYbKYizDf9Y4w4
	xVcFxNAL6h5Y74WWUCXojCr7BJX/Y3g1xRJkn06gzwpHmzbzDIunJXtbUOEhQframVrk09WP5QK
	OEuaD+RE5TmxZYaDiyqL6zf3C5sd2VNnZ5MirPEMHvIa7ZcXo2pn/DGZpVRz0gsPnq93Pzn0w99
	r32SgnvGcTKX7H84p8IYBImEkd1xhFoLPqWPz19angcoFFxQYeDgPMbe4FHQ==
X-Received: by 2002:a17:902:ecc7:b0:2ae:5464:7a4b with SMTP id d9443c01a7336-2b0826fce3emr1549985ad.14.1773942092781;
        Thu, 19 Mar 2026 10:41:32 -0700 (PDT)
Received: from [10.100.121.202] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e619ec3sm68658085ad.69.2026.03.19.10.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 10:41:32 -0700 (PDT)
Message-ID: <5f14aa38-af20-4ba1-9d33-31cd50f70e0f@gmail.com>
Date: Thu, 19 Mar 2026 10:41:29 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On WPA3 successful reconnect with wrong password after a forget
 network
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVS+V8Zbn+WV=G1eJ7pqipHNmhjd67pNM62vu8Lr_RkuVnw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVS+V8Zbn+WV=G1eJ7pqipHNmhjd67pNM62vu8Lr_RkuVnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 3/19/26 9:43 AM, Bryce Johnson wrote:
> Hi All,
> We ran into this edge case issue on only wpa3. If we forget a network
> and reconnect to the same network with an the incorrect password, it
> will connect anyways.  wpa1 and wpa2 don't reconnect.  This is on IWD
> 3.10.
>
Thanks for the report. I'm able to reproduce this as well. The issue is 
that with PMKSA we can see we got a match for a given SSID/MAC which 
totally bypasses the use of the passphrase, despite it being asked for. 
What we need to do is wipe all PMKSA entries for an SSID when the 
profile is removed.

Thanks,

James

