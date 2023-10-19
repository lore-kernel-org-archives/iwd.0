Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D182FE16
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heBRoxr+"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6cd33d51852so941980a34.2
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697728398; x=1698333198; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L66Pm9/ahRLZplgkvUoWQsu7x9SRT/XQeL+qjvBGnkk=;
        b=heBRoxr+AjCin8R05fDvgXOqwjii8YGf0HZ3ttaLWakb4xd/epuFbtnkQTrxFttguW
         RZ/gzIbS6kCEoVnSV7EfpP4U6KV8r574WO/4Bes5sd0O+d/z5QL9PFbpjkFtfS/AdZ+H
         ZNe7UF4V/aoJD2T9nEGzLRDEtYdA8Tan6pEIzdoqPLcWHWUY3xWUGsJ4qWMdzYvCrOIN
         Yu/Q+G80AoHnWHLLhMslhBeDgeodQ305GOxhRZbfD7INYyY3uIzv5eKIiRcNQFCzBVPV
         lRjtOPNC41VlaKzsMtWmM+swbaya7LXjvSwTG63Qy2Awb7LhZPQEAqkFeuYSuw+Lxwts
         tonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728398; x=1698333198;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L66Pm9/ahRLZplgkvUoWQsu7x9SRT/XQeL+qjvBGnkk=;
        b=TZggHRybTE8YgfgW9hQsQIqx+QObfGrsKYey1go/338eEFw7kGY4NrSHMLTF500R9W
         zw6RyEdtOi7X8FXXaxLD8F/IKyoB1TCGToLRFLOADPJZrFQP1RVkrEax4876QthxD7A1
         h6vsszbsOfzdq5lHWnLSR3Lhjd4z939VtvzWpq97+V81ZCHSxP3ApDw1aNzetV4fzdbK
         Oe3DxEgXcCNcBbNetvsQwNcnMdPyYZLzCFL9ZTdKUatng6vl5VXC30NE7mFKlv4Opc+6
         Q6GbvPCYuvDvufsFFtSQW0Z0R65RZPaQMjkeRefkQgIFBamzJZJw+JX6EWTYUvMzFEgw
         wLiA==
X-Gm-Message-State: AOJu0Ywwg8Z9LCKBWi7gqKNrkWjZriSaQJhNOiIk3+dZ3DRjZw9uCbG5
	kVg7oF++uN7rr5ue32/tE8fItzpDGQU=
X-Google-Smtp-Source: AGHT+IF/SZMwAQL9aiq3G7aZ4yJ3lL+/sMu6sK2nfGeEU5iryEXSIEs82taFESEdJAxQszXkyohgBQ==
X-Received: by 2002:a9d:6a4d:0:b0:6b8:6785:ed0b with SMTP id h13-20020a9d6a4d000000b006b86785ed0bmr2359249otn.30.1697728397904;
        Thu, 19 Oct 2023 08:13:17 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b7-20020a056830104700b006c6311b15f6sm1077079otp.38.2023.10.19.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:13:17 -0700 (PDT)
Message-ID: <856ccaf4-64fb-437c-9ba2-72702111f320@gmail.com>
Date: Thu, 19 Oct 2023 10:13:16 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] dpp-util: add crypto for PKEX
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-13-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-13-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> ---
>   src/dpp-util.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  32 ++++++++
>   2 files changed, 240 insertions(+)
> 

You may want to add some references to the code?  i.e. which part corresponds to 
what section in the spec.

> diff --git a/src/dpp-util.c b/src/dpp-util.c
> index 0406a4dc..b0556917 100644
> --- a/src/dpp-util.c
> +++ b/src/dpp-util.c
> @@ -39,6 +39,32 @@
>   #include "ell/asn1-private.h"
>   #include "src/ie.h"
>   

<snip>

> +
> +struct l_ecc_point *dpp_derive_q(const struct l_ecc_curve *curve,
> +					bool responder,
> +					const char *key,
> +					const char *identifier,
> +					const uint8_t *mac)

Should this use the [static 6] syntax?  Or I guess not since mac can be NULL. 
Why can mac be NULL?

We have derive_l_responder and derive_l_initiator, but derive_q has a boolean 
parameter?  Lets be consistent.

> +{
> +	_auto_(l_ecc_scalar_free) struct l_ecc_scalar *scalar = NULL;
> +	_auto_(l_ecc_point_free) struct l_ecc_point *ret = NULL;
> +	uint8_t hash[L_ECC_SCALAR_MAX_BYTES];
> +	unsigned int bytes = l_ecc_curve_get_scalar_bytes(curve);
> +	enum l_checksum_type type = dpp_sha_from_key_len(bytes);
> +	_auto_(l_ecc_point_free) struct l_ecc_point *p = NULL;
> +	const uint8_t *p_data = responder ? dpp_pkex_responder_p256 :
> +					dpp_pkex_initiator_p256;
> +	struct l_checksum *sha = l_checksum_new(type);
> +
> +	if (mac)
> +		l_checksum_update(sha, mac, 6);
> +
> +	if (identifier)
> +		l_checksum_update(sha, identifier, strlen(identifier));
> +
> +	l_checksum_update(sha, key, strlen(key));
> +	l_checksum_get_digest(sha, hash, bytes);
> +	l_checksum_free(sha);
> +
> +	/* Unlikely but can happen */
> +	scalar = l_ecc_scalar_new(curve, hash, bytes);
> +	if (!scalar)
> +		return NULL;
> +
> +	p = l_ecc_point_from_data(curve, L_ECC_POINT_TYPE_FULL,
> +					p_data, bytes * 2);
> +	if (!p)
> +		return NULL;
> +
> +	ret = l_ecc_point_new(curve);
> +
> +	if (!l_ecc_point_multiply(ret, scalar, p))
> +		return NULL;
> +
> +	return l_steal_ptr(ret);
> +}
> +
> +bool dpp_derive_z(const uint8_t *mac_i, const uint8_t *mac_r,

[static 6]?

> +				const struct l_ecc_point *n,
> +				const struct l_ecc_point *m,
> +				const struct l_ecc_point *k,
> +				const char *key,
> +				const char *identifier,
> +				void *z_out, size_t *z_len)
> +{
> +	const struct l_ecc_curve *curve = l_ecc_point_get_curve(n);
> +	size_t bytes = l_ecc_curve_get_scalar_bytes(curve);
> +	enum l_checksum_type sha = dpp_sha_from_key_len(bytes);
> +	uint8_t k_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t m_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t n_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t prk[L_ECC_SCALAR_MAX_BYTES];
> +
> +	l_ecc_point_get_x(k, k_x, sizeof(k_x));
> +	l_ecc_point_get_x(m, m_x, sizeof(m_x));
> +	l_ecc_point_get_x(n, n_x, sizeof(n_x));
> +
> +	hkdf_extract(sha, NULL, 0, 1, prk, k_x, bytes);
> +
> +	/* HKDF-Extract (since it doesn't take non-string arguments)*/
> +	prf_plus(sha, prk, bytes, z_out, bytes, 5, mac_i, 6, mac_r, 6, m_x,
> +			bytes, n_x, bytes, key, strlen(key));
> +
> +	*z_len = bytes;
> +
> +	return true;
> +}
> +
> +bool dpp_derive_u(const struct l_ecc_point *j,
> +			const uint8_t *mac_i,

[static 6]?

> +			const struct l_ecc_point *a,
> +			const struct l_ecc_point *y,
> +			const struct l_ecc_point *x,
> +			void *u_out, size_t *u_len)
> +{
> +	const struct l_ecc_curve *curve = l_ecc_point_get_curve(y);
> +	uint8_t j_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t a_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t y_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t x_x[L_ECC_SCALAR_MAX_BYTES];
> +	size_t bytes = l_ecc_curve_get_scalar_bytes(curve);
> +	enum l_checksum_type sha = dpp_sha_from_key_len(bytes);
> +	struct l_checksum *hmac;
> +
> +	l_ecc_point_get_x(j, j_x, bytes);
> +	l_ecc_point_get_x(a, a_x, bytes);
> +	l_ecc_point_get_x(y, y_x, bytes);
> +	l_ecc_point_get_x(x, x_x, bytes);
> +
> +	/* u = HMAC(J.x, MAC-Initiator | A.x | Y'.x | X.x)*/
> +	hmac = l_checksum_new_hmac(sha, j_x, bytes);
> +	l_checksum_update(hmac, mac_i, 6);
> +	l_checksum_update(hmac, a_x, bytes);
> +	l_checksum_update(hmac, y_x, bytes);
> +	l_checksum_update(hmac, x_x, bytes);
> +	l_checksum_get_digest(hmac, u_out, bytes);
> +	l_checksum_free(hmac);
> +
> +	*u_len = bytes;
> +
> +	return true;
> +}
> +
> +bool dpp_derive_v(const struct l_ecc_point *l, const uint8_t *mac,

And here?

> +			const struct l_ecc_point *b,
> +			const struct l_ecc_point *x,
> +			const struct l_ecc_point *y,
> +			uint8_t *v_out, size_t *v_len)
> +{
> +	const struct l_ecc_curve *curve = l_ecc_point_get_curve(l);
> +	uint8_t l_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t b_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t x_x[L_ECC_SCALAR_MAX_BYTES];
> +	uint8_t y_x[L_ECC_SCALAR_MAX_BYTES];
> +	size_t bytes = l_ecc_curve_get_scalar_bytes(curve);
> +	enum l_checksum_type sha = dpp_sha_from_key_len(bytes);
> +	struct l_checksum *hmac;
> +
> +	l_ecc_point_get_x(l, l_x, sizeof(l_x));
> +	l_ecc_point_get_x(b, b_x, sizeof(b_x));
> +	l_ecc_point_get_x(x, x_x, sizeof(x_x));
> +	l_ecc_point_get_x(y, y_x, sizeof(y_x));
> +
> +	hmac = l_checksum_new_hmac(sha, l_x, bytes);
> +
> +	if (mac)
> +		l_checksum_update(hmac, mac, 6);
> +
> +	l_checksum_update(hmac, b_x, bytes);
> +	l_checksum_update(hmac, x_x, bytes);
> +	l_checksum_update(hmac, y_x, bytes);
> +	l_checksum_get_digest(hmac, v_out, bytes);
> +	l_checksum_free(hmac);
> +
> +	*v_len = bytes;
> +
> +	return true;
> +}

<snip>

Unit tests?

Regards,
-Denis

