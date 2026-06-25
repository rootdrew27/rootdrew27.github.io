import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const blog = defineCollection({
	// Load Markdown and MDX files in the `src/content/blog/` directory.
	loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
	// Type-check frontmatter using a schema
	schema: ({ image }) =>
		z.object({
			title: z.string(),
			description: z.string(),
			// Transform string to Date object
			pubDate: z.coerce.date(),
			updatedDate: z.coerce.date().optional(),
			heroImage: z.optional(image()),
			heroImageAlt: z.string().optional(),
			heroImageCredit: z.string().optional(),
		}),
});

const resume = defineCollection({
	// Load the structured resume data from `src/content/resume/`.
	loader: glob({ base: './src/content/resume', pattern: '**/*.{yaml,yml}' }),
	schema: z.object({
		pdfPath: z.string(),
		profile: z.object({
			name: z.string(),
			title: z.string(),
			location: z.string().optional(),
			email: z.string(),
			summary: z.string().optional(),
			links: z.array(z.object({ label: z.string(), href: z.string() })),
		}),
		experience: z.array(
			z.object({
				role: z.string(),
				company: z.string(),
				location: z.string().optional(),
				start: z.string(),
				end: z.string(),
				summary: z.string().optional(),
				highlights: z.array(z.string()),
			}),
		),
		projects: z.array(
			z.object({
				name: z.string(),
				href: z.string().optional(),
				description: z.string(),
				tech: z.array(z.string()).optional(),
				highlights: z.array(z.string()).optional(),
			}),
		),
		leadership: z.array(
			z.object({
				role: z.string(),
				description: z.string(),
			}),
		),
		skills: z.array(
			z.object({
				category: z.string(),
				items: z.array(z.string()),
			}),
		),
		education: z.array(
			z.object({
				institution: z.string(),
				credential: z.string(),
				start: z.string().optional(),
				end: z.string(),
				details: z.array(z.string()).optional(),
			}),
		),
		honors: z.array(
			z.object({
				title: z.string(),
				issuer: z.string().optional(),
				date: z.string(),
			}),
		),
	}),
});

export const collections = { blog, resume };
