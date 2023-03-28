Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9401947A
	for <iwd@lists.linux.dev>; Tue, 28 Mar 2023 15:51:02 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id x20so13043707ljq.9
        for <iwd@lists.linux.dev>; Tue, 28 Mar 2023 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680018661;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=37OUlF2Ag4vHNQXiobjSywH+BX5eAaNm9KnwPkSTdK8=;
        b=AFwEnma4OvLiN8+dif6I1V3P2wAnLnSBZvwffzWV1vT55GGhPuGcm7SJWMT78SolXn
         oeYqGcw9KS/AMgfS4ICxBvt6WuSRQY231Qm2oLVOX6KRnQzpoUJCWtWouagXMJhDFF1Y
         n1TgyzXQQnn19UAJktWXETRr2QuRcZSMyDu7b++HUVy6myqGvtUwzd/EZE1/tbR9I0uN
         uxjO+d8s+oIFStUgLQjqHCTXY8SxIGOEcbQxsXJco8ac6UlwUFh2G9H1xV0L7/PNJw8K
         MB48bqEkPSC4PKKeEQjVMibseaHsu2IpeSGxLLkfR6GXkjOthSlo4Svd1Ajoi/iwreow
         4sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018661;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37OUlF2Ag4vHNQXiobjSywH+BX5eAaNm9KnwPkSTdK8=;
        b=KymPLg9tRDpHgSoI6ka0tfYoH+jbC1GYITiftMJ0m7Ey9ux1x2YyxTe2Ig0w7GnZXU
         2PQXK4SmP+EQjl0TRfemGDqiS+qPtOnU5tpNXsWSQFYFwvEDQ4hc9+65GxgwzUxona6+
         VJ7VYVqbLnwKcJ3slqBueDhdE++uRDCEydBOasZBNncadX0Ez9T5hkQbUqmOiC9jJrTW
         94eUL3pxgKDeeikj6g5Mo79D+TO3tPTYyHABQqFbskOAm8ECwiJWggNR+WCKEPiz98q6
         jrFJ81yVOF/AyEjTdPqvCZ26JuL1jzDN3faxwcnXat2G3v0LpvqgZmi6w1FmUhVPbxCf
         X1Ug==
X-Gm-Message-State: AAQBX9c0+GPOmUjLtoAQoty+lLZzMjj8RAQawZCQmNyqf5WAiYqNa55d
	YJGqhOep/oLXa4nyOW1Z7gH0bylaCyY=
X-Google-Smtp-Source: AKy350aVfI3EwGzCUJqBETEk6cVK4DG6C/LVAjEi49StW8JbfKivBXiuGJudP5kIM/UWi7/uPeu+AA==
X-Received: by 2002:a2e:99d0:0:b0:298:a852:d387 with SMTP id l16-20020a2e99d0000000b00298a852d387mr5205604ljj.13.1680018660529;
        Tue, 28 Mar 2023 08:51:00 -0700 (PDT)
Received: from nl6720 (balticom-231-46.balticom.lv. [83.99.231.46])
        by smtp.gmail.com with ESMTPSA id r10-20020a2eb60a000000b002945b851ea5sm5104855ljn.21.2023.03.28.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:50:59 -0700 (PDT)
From: nl6720 <nl6720@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
Subject: Re: [PATCH] man: enclose referenced man page names in bold
Date: Tue, 28 Mar 2023 18:50:54 +0300
Message-ID: <5016407.zvgtpshpmF@walnut>
In-Reply-To: <94DE8A03-1C36-424C-B5E2-A1A0DF2CA971@holtmann.org>
References:
 <20230321161905.161909-1-nl6720@gmail.com>
 <94DE8A03-1C36-424C-B5E2-A1A0DF2CA971@holtmann.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4265432.L0hBIgghgN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4265432.L0hBIgghgN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: nl6720 <nl6720@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
Subject: Re: [PATCH] man: enclose referenced man page names in bold
Date: Tue, 28 Mar 2023 18:50:54 +0300
Message-ID: <5016407.zvgtpshpmF@walnut>
In-Reply-To: <94DE8A03-1C36-424C-B5E2-A1A0DF2CA971@holtmann.org>
MIME-Version: 1.0

On Friday, 24 March 2023 16:12:58 EEST Marcel Holtmann wrote:
> can you fix your git config and add real name info to the author
> information please.
> 
> Regards
> 
> Marcel

Sorry, but I have no intention of revealing my name.

nl6720
--nextPart4265432.L0hBIgghgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQJGlXQbhb/L1xVy7xc6IU14YjTaQUCZCMM3gAKCRBc6IU14YjT
aX0BAP9fCTt3BVLBVt3au+xJFw/DEoXGNLwo54lReJGtEsIVVAEA8eF9E+eI7L8b
ZCOo4vRjXAoPi4p2+FRQ8zPhJi9Cvwg=
=PDLO
-----END PGP SIGNATURE-----

--nextPart4265432.L0hBIgghgN--



