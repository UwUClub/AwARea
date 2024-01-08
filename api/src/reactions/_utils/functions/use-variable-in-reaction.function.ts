import { ReactionDocumentType } from '../../schemas/reactions.schema';

export function mergeObjects(obj1, obj2) {
  if (typeof obj1 !== 'object' || typeof obj2 !== 'object') {
    throw new Error('Les deux arguments doivent être des objets.');
  }
  const result = { ...obj2 };

  for (const key in result) {
    if (typeof result[key] !== 'string') continue;
    if (result[key].includes('${')) {
      const regex = /\${(.*?)}/g;
      result[key] = result[key].replace(regex, (match, capture) => {
        const value = obj1[capture.trim()];
        return value !== undefined ? value : match;
      });
    }
  }

  return result;
}
